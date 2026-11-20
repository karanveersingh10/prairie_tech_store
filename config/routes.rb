Rails.application.routes.draw do
  devise_for :customers
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root "products#index"

  resources :categories, only: [:show]
  resources :products, only: [:index, :show]

  get "cart", to: "carts#show", as: :cart
  post "cart/add/:product_id", to: "carts#add", as: :add_to_cart
  patch "cart/:product_id", to: "carts#update", as: :update_cart_item
  delete "cart/:product_id", to: "carts#remove", as: :remove_cart_item
  delete "cart", to: "carts#clear", as: :clear_cart


  get "checkout", to: "checkouts#show", as: :checkout
  post "checkout", to: "checkouts#create"
  get "my_orders", to: "orders#index", as: :my_orders
  get "orders/:id", to: "orders#show", as: :order

  get "about", to: "pages#about"
  get "contact", to: "pages#contact"
end
