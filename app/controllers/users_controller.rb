# frozen_string_literal: true
class UsersController < ApplicationController
  skip_before_action :authorize, only: :create

  def all_friends
    @users = current_user.friends
    render(json: @users.as_json(only: %i[id nickname]))
  end

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
      render(json: { err: 1, err_arr: @user.errors.full_messages })
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
