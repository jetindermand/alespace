class MicropostsController < ApplicationController

  before_filter :correct_user, only: :destroy

  def create
    @micropost = current_user.microposts.build(params[:micropost])
    if @micropost.save      
      track_activity @micropost
      flash[:success] = "Posted!"
      redirect_to user_path(current_user)
    else
      @feed_items = []
      redirect_to user_path(current_user)
    end
  end

  def destroy
    @micropost.destroy
    track_activity @micropost
    redirect_to user_path(current_user)
  end

  private

    def correct_user
      @micropost = current_user.microposts.find_by_id(params[:id])
      redirect_to root_url if @micropost.nil?
    end
end