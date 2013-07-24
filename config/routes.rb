Rails3BootstrapDeviseCancan::Application.routes.draw do
  resources :activities


  get "breweries/new"

  get "beers/new"

  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users
  resources :users do
    member do
      get :cellar, :following, :followers
    end
  end

  resources :breweries
  resources :beers
  resources :microposts, only: [:create, :destroy]
  resources :cellared_beers, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
end