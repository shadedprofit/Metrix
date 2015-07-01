Rails.application.routes.draw do
  
  get 'welcome/index'

  get 'about' => 'welcome#about'

  devise_for :users
  # resources :users, only: [:update, :show]

  root to: 'welcome#index'
end
