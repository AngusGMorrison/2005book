class ApplicationController < ActionController::Base

  private

  def current_user
    session[:user_id] ? User.find(session[:user_id]) : User.new
  end

  def require_logged_in
    head(:forbidden) unless session[:user_id]
  end

end
