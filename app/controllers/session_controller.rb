class SessionController < ApplicationController
  before_action :require_logged_out, only: [:new, :create]

  def new
    @current_user = current_user
  end

  def create
    @current_user = User.find_by(email: params[:user][:email])

    if @current_user.try(:authenticate, params[:user][:password])
      begin_session
    else
      reject_login
    end
  end

  def destroy
    session.destroy
    redirect_to root_path
  end

  private

  def reject_login
    flash[:login_error] = "Email or password not recognized"
    redirect_to login_path
  end

end
