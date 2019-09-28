class ApplicationController < ActionController::Base
  helper_method :current_user
  
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

  def begin_session(user_id)
    session[:user_id] = user_id
    redirect_to profile_path
  end

end
