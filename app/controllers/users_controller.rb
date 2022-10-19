# frozen_string_literal: true
class UsersController < ApplicationController
  skip_before_action :authorize, only: :create

  # GET /get_friends
  # def all_friends
  #   @users = current_user.friends
  #   render(json: @users.as_json(only: %i[id nickname]))
  # end

  # POST /signup
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      render(json: {
        err: 0,
        msg: "Sign up success",
        id: @user.id,
        email: @user.email,
        nickname: @user.nickname
      })
    else
      render(status: 400, json: { err: 1, err_arr: @user.errors.full_messages })
    end
  end

  # POST /add_friend
  def add_friend
    if params[:keyword].present?
      friend = User.find_by_sql(["
        SELECT * FROM users WHERE email = ?
        UNION
        SELECT * FROM users WHERE nickname = ?
      ", params[:keyword], params[:keyword]])
      if !friend.empty?
        friend = friend[0]
        existed_direct_room = Room.direct_room_by_id(current_user.id, friend.id)
        unless existed_direct_room.empty?
          render(status: 403, json: { err: 1, msg: "This user has already been added" })
          return
        end
        room = Room.create(room_type: :direct_room)
        if room
          room.participants.create([
            { user: current_user, status: :accepted },
            { user: friend, status: :invite_pending }
          ])
          render(json: {
            err: 0,
            room: {
              id: room.id,
              is_current: 0,
              user_nickname: friend.nickname,
              messages: []
            }
          })
        else
          render(status: 400, json: { err: 1, msg: room.errors.full_messages })
        end
      else
        render(status: 404, json: { err: 1, msg: "Email or Nickname doesn't exist" })
      end
    end
  end

  private

  def user_params
    params.permit(
      :email,
      :password,
      :nickname,
      :first_name,
      :last_name
    )
  end
end
