Rails.application.routes.draw do
  
  resources :charges, only: [:create, :new, :destroy]
  resources :wikis

  devise_for :users
  get 'about' => 'welcome#about'
  root 'welcome#index'
end
