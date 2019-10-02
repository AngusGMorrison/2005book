class StaticController < ApplicationController
  before_action :require_logged_out

  def index
    @current_user = current_user
  end

  private

  

end
