Rails.application.routes.draw do

  devise_for :users
  root to: 'items#index'
  resources :items do
    resources :orders
  end
  resources :cards, only: [:new, :create]
end
