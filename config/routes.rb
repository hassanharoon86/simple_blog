Rails.application.routes.draw do
  devise_for :users

  resources :posts do
    resources :likes, only: [:create, :destroy], module: 'posts'
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"
end
