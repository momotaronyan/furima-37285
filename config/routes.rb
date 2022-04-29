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
  end
  resources :cards, only: [:new, :create]
  resources :users, only: [:show, :edit, :update]
end
