class ProfilesController < ApplicationController
  before_action :require_logged_in

  def show
    @profile = Profile.find_by(slug: params[:slug])
    @user = current_user
  end

end