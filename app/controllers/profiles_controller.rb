class ProfilesController < ApplicationController
  before_action :require_logged_in

  def show
    @user = current_user
    @profile = Profile.find_by(slug: params[:slug])
    @profile_owner = @profile.user
  end

end