class UsersController < ApplicationController
  before_action :require_logged_in, only: :show
  before_action :require_logged_out, only: [:new, :create]

  def new
    @user = current_user
    @mods = Mod.all
  end

  def create
    @user = User.create(user_params)

    if @user.valid?
      begin_session(@user.id)
    else
      render_registration_form_with_errors
    end
  end

  def show
    @user = current_user
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

  def render_registration_form_with_errors
    @mods = Mod.all
    @errors = @user.errors
    render "new"
  end

end
