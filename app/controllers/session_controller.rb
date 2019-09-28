class SessionController < ApplicationController
  before_action :require_logged_out, only: [:new, :create]

  def new
  end

  def create
    user = User.find_by(email: params[:user][:email])
    if user.try(:authenticate, params[:user][:password])
      begin_session(user.id)
    else
      reject_credentials
    end
  end

  def destroy
    session.destroy
    redirect_to root_path
  end

  private

  def reject_credentials
    flash[:login_error] = "Email or password not recognized"
    redirect_to login_path
  end

end
