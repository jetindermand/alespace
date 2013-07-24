class BeersController < ApplicationController
  def new
  	@beer = Beer.new
  end

  def create
    @beer = Beer.new(params[:beer])
    @beer.brewery_id.to_i
    if @beer.save
      flash[:success] = "Added Beer"
      redirect_to @beer
    else
      render 'new'
    end
  end

  def destroy
  	Beer.find(params[:id]).destroy
    flash[:success] = "Beer destroyed."
    redirect_back_or beers_url
  end

  def edit
    @beer = Beer.find(params[:id])
  end

  def update
    @beer = Beer.find(params[:id])
  	if @beer.update_attributes(params[:beer])
      flash[:success] = "Beer updated"
      redirect_to @beer
    else
      render 'edit'
    end
  end

  def index
    @beers = Beer.paginate(page: params[:page])
  end

  def show
  	@beer = Beer.find(params[:id])
    if request.path != beer_path(@beer)
      redirect_to @beer, status: :moved_permanently
    end
  end

  def cellar
    @beer = Beer.find(params[:id])
    @title = "People cellaring " + @beer.name
    @users = @beer.users.paginate(page: params[:page])
  end
end
