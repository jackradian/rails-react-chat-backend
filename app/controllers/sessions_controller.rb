# frozen_string_literal: true
class SessionsController < ApplicationController
  skip_before_action :authorize, only: :create

  def create
    user = User.find_by_email(params[:email])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      render(json: {
        err: 0,
        msg: "Login Success",
        id: user.id,
        email: user.email,
        nickname: user.nickname
      })
    else
      render(json: { err: 1, msg: "Invalid Email or Password" })
    end
  end

  def destroy
    session[:user_id] = nil
    render(json: { err: 0, msg: "Logged Out!" })
  end
end
