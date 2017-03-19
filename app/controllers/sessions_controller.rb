class SessionsController < ApplicationController
  skip_before_action :authenticate

  layout 'session'
  def new
  end

  def create
    @user = User.authentication(params[:username], params[:password])
    if @user
      session[:user_id] = @user.id
      redirect_to root_path
    else
      redirect_to new_session_path
    end
  end

  def signout
    session[:user_id] = nil
    redirect_to new_session_path
  end
end
