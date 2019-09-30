class ProfilesController < ApplicationController
  before_action :require_logged_in
  before_action :forbid_unauthorized_edits, only: :edit

  def show
    @current_user = current_user
    @profile = Profile.find_by(slug: params[:slug])
    @profile_owner = @profile.user
  end

  def edit
  end

  private

  def forbid_unauthorized_edits
    profile_owner = Profile.find_by(slug: params[:slug])
    head(:forbidden) if current_user != profile_owner
  end

end