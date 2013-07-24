class BreweriesController < ApplicationController
  def new
  	@brewery = Brewery.new
  end

  def create
    @brewery = Brewery.new(params[:brewery])
    if @brewery.save
      flash[:success] = "Added Brewery"
      redirect_to @brewery
    else
      render 'new'
    end
  end

  def destroy
  	Brewery.find(params[:id]).destroy
    flash[:success] = "Brewery destroyed."
    redirect_to breweries_url
  end

  def edit
    @brewery = Brewery.find(params[:id])
  end

  def update
    @brewery = Brewery.find(params[:id])
  	if @brewery.update_attributes(params[:brewery])
      flash[:success] = "Brewery updated"
      redirect_to @brewery
    else
      render 'edit'
    end
  end

  def index
    @breweries = Brewery.paginate(page: params[:page])
  end

  def show
  	@brewery = Brewery.find(params[:id])
    @beers = @brewery.beers.paginate(page: params[:page])
    if request.path != brewery_path(@brewery)
      redirect_to @brewery, status: :moved_permanently
    end
  end

end
