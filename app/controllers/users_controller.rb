class UsersController < ApplicationController
  before_action :require_logged_in, only: :show

  def new
    @user = current_user
    @mods = Mod.all
  end

  def create
    @user = User.create(user_params)

    if @user.valid?
      session[:user_id] = @user.id
      redirect_to profile_path
    else
      @mods = Mod.all
      @errors = @user.errors
      render "new"
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

end
