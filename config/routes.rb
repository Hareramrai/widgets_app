Rails.application.routes.draw do
  get 'home/index'
  resources :sessions

  root to: 'home#index'
end
