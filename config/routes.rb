Rails.application.routes.draw do
  get 'home/index'
  
  resource :session, only: [:new, :create] do 
    delete :destroy, as: "destroy"
  end
  
  resource :registration
  resource :password, only: [:new, :create]

  root to: 'home#index'
end
