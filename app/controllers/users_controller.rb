class UsersController < ApplicationController
  skip_before_action :authorize, only: :create

  def index
  end

  def new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      render json: { err: 0, msg: "Sign up success" }
    else
      render json: { err: 1, msg: "Sign up failed" }
    end
  end

private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
