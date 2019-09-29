class ApplicationController < ActionController::Base

  private

  def current_user
    session[:user_id] ? User.find(session[:user_id]) : User.new
  end

  def require_logged_in
    redirect_to login_path unless session[:user_id]
  end

  def require_logged_out
    redirect_to profile_path if session[:user_id]
  end

  def begin_session
    session[:user_id] = @user.id
    redirect_to profile_path
  end

end
