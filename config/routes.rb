Rails.application.routes.draw do

  resource :session, only: [:new, :create] do 
    delete :destroy, as: "destroy"
  end
  
  resource :registration
  resource :password, only: [:new, :create]

  resources :widgets

  resources :users, only:[] do 
    scope module: :users do
      resources :widgets
    end
  end

  root to: 'widgets#index'
end
