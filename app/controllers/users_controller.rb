class UsersController < ApplicationController
  before_action :require_logged_in, only: :show
  before_action :require_logged_out, only: [:new, :create]

  # to test friendship feature...
  def index
    # returns an array of all user objects, excluding current user
    @users = User.all.reject{ |user| user.id == current_user.id }
  end

  def new
    @user = current_user
    @mods = Mod.all
  end

  def create
    @user = User.create(user_params)

    if @user.valid?
      begin_first_session
    else
      render_registration_form_with_errors
    end
  end

  def show
    @user = current_user
  end

  # returns an array of friends (where Friendship status == "Accepted)
  def friends
    current_user
    @friends = current_user.accepted_friends
  end

  private

  def user_params
    params.require(:user).permit(
      :name,
      :mod_id,
      :email,
      :password,
      :accepted_terms
    )
  end

  def begin_first_session
    create_profile
    begin_session
  end


  def create_profile
    profile = Profile.create(user_id: @user.id)
    profile.generate_slug
  end

  def render_registration_form_with_errors
    @mods = Mod.all
    @errors = @user.errors
    render "new"
  end

end
