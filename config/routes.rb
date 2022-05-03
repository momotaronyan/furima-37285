Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }
  get 'users/show'
  root to: 'items#index'
  resources :items do
    resources :orders
    collection do
      get 'search'
    end
    resources :comments, only: :create
    resource :favorites, only: [:create, :destroy]
  end
  resources :cards, only: [:new, :create, :edit, :update]
  resources :users, only: [:show, :edit, :update]
  resources :connects, only: [:index, :create]
end
