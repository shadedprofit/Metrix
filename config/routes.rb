Rails.application.routes.draw do

  get 'users/show'

  get 'welcome/index'

  get 'about' => 'welcome#about'

  devise_for :users
  resources :users, only: [:update, :show]

  resources :registered_applications

  namespace :api, defaults: { format: :json } do
    resources :events, only: [:create]
    match 'create_event', to: 'events#create', via: [:options]
  end

  root to: 'welcome#index'
end
