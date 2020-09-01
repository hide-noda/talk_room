Rails.application.routes.draw do
  get 'messages/index'
  devise_for :users
  root to: "rooms#index"
  resources :users, only: [:edit, :update]
  resources :rooms, only: [:new, :create, :edit, :update, :destroy] do
    resources :messages, only: [:index, :create, :destroy]
  end
  get 'messages/:id', to: 'messages#checked'
end
