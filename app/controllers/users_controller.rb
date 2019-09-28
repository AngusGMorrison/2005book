class UsersController < ApplicationController

  def new
    @user = User.new
    @mods = Mod.all
  end

  def create
    @user = User.create(user_params)

    if @user.valid?
      # Create session
      redirect_to profile_path
    else
      @mods = Mod.all
      @errors = @user.errors
      render "new"
    end

  end

  def show
    @user = User.last
  end


  private

  def user_params
    params.require(:user).permit(:name, :mod_id, :email, :password)
  end

end
