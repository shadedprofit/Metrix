Rails.application.routes.draw do

  get 'users/show'

  get 'welcome/index'

  get 'about' => 'welcome#about'

  resources :registered_applications

  devise_for :users
  resources :users, only: [:update, :show]

  root to: 'welcome#index'
end
