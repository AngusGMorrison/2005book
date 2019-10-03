class UsersController < ApplicationController
  before_action :require_logged_in, only: :show
  before_action :require_logged_out, only: [:new, :create]

  def index
    # returns an array of all user objects, excluding current user
    @current_user = current_user
    @users = User.all.reject{ |user| user.id == current_user.id }.sort_by{ |user| user.name }
  end

  def new
    @current_user = current_user
    @mods = Mod.all
  end

  def create
    @current_user = User.create(user_params)
    if @current_user.valid?
      begin_first_session
    else
      render_registration_form_with_errors
    end
  end

  def friends
    @current_user = current_user
    @friends = @current_user.friends
    @requests = @current_user.friend_requests
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
    Profile.create_profile_with_slug(@current_user.id)
    begin_session
  end

  def render_registration_form_with_errors
    @mods = Mod.all
    @errors = @current_user.errors
    render "new"
  end

end
