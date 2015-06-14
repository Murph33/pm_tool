Rails.application.routes.draw do
  root "home#index"

  get "/home/about" => "home#about"


  
  resources :projects do
    resources :tasks, :discussions
  end

  post "search" => "projects#index"

  resources :discussions, only: [] do
    resources :comments
  end


end
