class ApplicationController < ActionController::Base
  helper_method :current_user

  def current_user
    session[:user_id] ? User.find(session[:user_id]) : User.new
  end

  private


  def require_logged_in
    redirect_to login_path unless session[:user_id]
  end

  def require_logged_out
    if session[:user_id]
      @profile = Profile.find_by(user_id: session[:user_id])
      redirect_to profile_path(@profile.slug)
    end
  end

  def begin_session
    session[:user_id] = @current_user.id
    redirect_to profile_path(@current_user.profile.slug)
  end

end
