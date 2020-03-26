class ApplicationController < ActionController::API
  before_action :authorize
  helper_method :current_user

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    else
      @current_user = nil
    end
  end

  def authorize
    render json: { err: 1, msg: "Invalid" }, status: 401 if current_user.nil?
  end
end
