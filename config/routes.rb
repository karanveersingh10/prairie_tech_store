Rails.application.routes.draw do
  root "products#index"

  resources :categories, only: [:show]
  resources :products, only: [:index, :show]
end