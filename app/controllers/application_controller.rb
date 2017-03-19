class ApplicationController < ActionController::Base
  protect_from_forgery with: :reset_session

  before_action :authenticate

  helper_method :current_user

  protected

  def authenticate
    return redirect_to new_session_url unless session[:user_id]
    @current_user = User.find(session[:user_id])
  end

  def current_user
    @current_user
  end
end
