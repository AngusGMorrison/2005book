class SessionController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:user][:email])

    if @user.authenticate(params[:user][:password])
      SessionController.begin_session(user.id)
    else
      SessionController.reject_credentials
    end

  end

  def destroy
    session.destroy
    redirect_to root_path
  end

  private

  def self.begin_session(user_id)
    session[:user_id] = user_id
    redirect_to profile_path
  end

  def self.reject_credentials
    flash[:error] = "Email or password not recognized"
    redirect_to login_path
  end

end
