class RelationshipsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @user = User.find(params[:relationship][:followed_id])
    @relationship = current_user.follow!(@user)
    track_activity @relationship
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    @relationship = current_user.unfollow!(@user)
    track_activity @relationship
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end
end