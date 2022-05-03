Rails.application.routes.draw do
  get 'favorites/create'
  get 'favorites/destroy'
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
  resources :users, only: [:show, :edit, :update] do
    member do
      get :favorites
    end
  end
  resources :connects, only: [:index, :create]
end
