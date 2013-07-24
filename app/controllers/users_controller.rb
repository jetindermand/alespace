class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :user_info, :only => [:show, :cellar]

  def index
    authorize! :index, @user, :message => 'Not authorized as an administrator.'
    @users = User.all
  end

  def show
    @news_feed_items = Activity.order("created_at desc").where(user_id: [current_user.followed_user_ids, current_user], action: "create").paginate(page: params[:page])
    @users_activities = Activity.order("created_at desc").where(user_id: [@user], action: "create").paginate(page: params[:page])
  end
  
  def update
    authorize! :update, @user, :message => 'Not authorized as an administrator.'
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user], :as => :admin)
      redirect_to users_path, :notice => "User updated."
    else
      redirect_to users_path, :alert => "Unable to update user."
    end
  end
    
  def destroy
    authorize! :destroy, @user, :message => 'Not authorized as an administrator.'
    user = User.find(params[:id])
    unless user == current_user
      user.destroy
      redirect_to users_path, :notice => "User deleted."
    else
      redirect_to users_path, :notice => "Can't delete yourself."
    end
  end

  def cellar
    @title = @user.name + "'s Cellar"
    @user = User.find(params[:id])
    @cellared_beers = @user.cellared_beers
#    beer_groups = @user.cellared_beers.find(:all,
#                                            :select => "beer_id, year, size",
#                                            :group => "beer_id, year, size")
    beer_groups = @user.cellared_beers.count(:group => [:beer_id,:year,:size])
#    @beer_counts = beer_groups.map {|beer_id,beers| [beers.first, beers.size]}
    @beer_counts = beer_groups.map do |values,count|
      beer = Beer.find(values[0])
      [beer.id, beer.name, beer.brewery.id, beer.brewery.name, beer.style, beer.abv, values[1], values[2], count]
    end
    render 'show_cellar', :message => 'Added beer to cellar'
  end

protected
  def user_info
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
    @micropost = current_user.microposts.build if signed_in?
    @following = @user.followed_users.paginate(page: params[:page])
    @followers = @user.followers.paginate(page: params[:page])
  end


end