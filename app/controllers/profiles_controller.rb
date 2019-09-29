class ProfilesController < ApplicationController

  def show
    @profile = Profile.find_by(slug: params[:slug])
    @user = current_user
  end

end