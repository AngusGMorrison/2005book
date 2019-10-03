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
  end

  def update
    @profile = find_profile_from_slug
    @current_user = current_user

    update_profile_and_user
    if @profile.valid? && @current_user.valid?
      redirect_to profile_path(current_user.profile.slug)
    else
      render :edit
    end
  end

  private

  def forbid_unauthorized_edits
    profile_owner = find_profile_from_slug.user
    head(:forbidden) if current_user != profile_owner
  end

  def find_profile_from_slug
    Profile.find_by(slug: params[:slug])
  end

  def update_profile_and_user
    @profile.update_after_edit(permitted_params)
    @current_user.update(permitted_params[:user])
  end

  def permitted_params
    params.require(:profile).permit(
      :websites,
      :interested_in,
      :political_view_id,
      :interests,
      :books,
      :movies,
      :photo_url,
      :music,
      :about_me,
      :studies,
      :sex,
      :hometown,
      :email,
      :screenname,
      :phone_number,
      :looking_for_options => [],
      user: [
        :name,
        :email,
        :"birthday(1i)",
        :"birthday(2i)",
        :"birthday(3i)",
        :mod_id
      ]  
    ) 
  end

end