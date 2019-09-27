class ApplicationController < ActionController::Base

  def authenaticated_user_id
    session[:user_id]
  end

  private

  def check_logged_in
    head(:forbidden) unless authenticated_user_id
  end

end
