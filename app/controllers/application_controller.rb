class ApplicationController < ActionController::Base

  private

  def current_user
    User.find(session[:user_id]) || User.new
  end

  def require_logged_in
    head(:forbidden) unless session[:user_id]
  end

end
