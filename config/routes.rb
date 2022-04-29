Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }
  get 'users/show'
  devise_for :users
  root to: 'items#index'
  resources :items do
    resources :orders
  end
  resources :cards, only: [:new, :create]
  resources :users, only: [:show, :edit, :update]
end
