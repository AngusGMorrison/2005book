class UsersController < ApplicationController

  def new
    @user = User.new
    @mods = Mod.all
  end

  def create
    @user = user.create(users_params)

    if @user.valid?
      # Create session
      redirect_to user_path
    else
      render :new
    end

  end


  private

  def user_params
    params.require(:user).permit(:name, :mod, :email, :password)
  end

end
