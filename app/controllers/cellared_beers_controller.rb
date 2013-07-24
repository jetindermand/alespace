class CellaredBeersController < ApplicationController
  before_filter :authenticate_user!

  def create
      @cellared_beer = current_user.cellared_beers.build(params[:cellared_beer])
      if @cellared_beer.save
        track_activity @cellared_beer
        flash[:success] = "Beer cellared!"
        redirect_to cellar_user_path(current_user)
      else
        flash[:success] = "Cellaring FAILS!"
        redirect_to user_path(current_user)
      end
  end

  def destroy
    @beer = Cellared_beer.find(params[:id]).followed
    @cellared_beer = current_user.uncellar!(@beer)
    track_activity @cellared_beer
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end
end