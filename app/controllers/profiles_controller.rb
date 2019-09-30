class ProfilesController < ApplicationController
  before_action :require_logged_in
  before_action :forbid_unauthorized_edits, only: :edit

  def show
    @current_user = current_user
    @profile = find_profile_from_slug
    @profile_owner = @profile.user
  end

  def edit
    @current_user = current_user
    @profile = find_profile_from_slug
    @mods = Mod.all
    @looking_for_options = LookingForOption.all
    @political_views = PoliticalView.all
  end

  def update
    byebug
  end

  private

  def forbid_unauthorized_edits
    profile_owner = find_profile_from_slug.user
    head(:forbidden) if current_user != profile_owner
  end

  def find_profile_from_slug
    Profile.find_by(slug: params[:slug])
  end

end