class SessionsController < ApplicationController
  skip_before_action :authorize, only: :create

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      render json: { err: 0, msg: "Login Success" }
    else
      render json: { err: 1, msg: "Login Failed" }
    end
  end

  def destroy
    session[:user_id] = nil
    render json: { err: 0, msg: "Logged out!" }
  end
end
