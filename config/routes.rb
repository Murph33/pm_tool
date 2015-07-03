Rails.application.routes.draw do


  get 'sessions/new'

  root "home#index"

  get "/home/about" => "home#about"

  resources :favourites, only: [:index]

  resources :users, only: [:new, :create] do
    get :edit, on: :collection
    patch :update, on: :collection
  end

  resources :projects do
    resources :favourites, only: [:create, :destroy, :update]
    resources :tasks, :discussions
  end

  post "search" => "projects#index"

  resources :discussions, only: [] do
    resources :comments
  end

  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end

  match "/delayed_job" => DelayedJobWeb, :anchor => false, via: [:get, :post]

end
