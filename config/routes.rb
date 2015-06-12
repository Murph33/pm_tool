Rails.application.routes.draw do
  root "home#index"

  get "/home/about" => "home#about"



  resources :projects do
    resources :tasks
  end

  post "search" => "projects#index"

end
