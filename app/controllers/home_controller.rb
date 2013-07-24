class HomeController < ApplicationController
  def index
  	if signed_in?
  		redirect_to user_path(current_user)
  	else
    	@users = User.all
    end
  end
end
