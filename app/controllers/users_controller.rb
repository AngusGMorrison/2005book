class UsersController < ApplicationController

  def new
    @user = User.new
    @mods = Mod.all
  end
end
