Rails.application.routes.draw do
  get 'home/index'
  
  resource :session, only: [:new, :create] do 
    delete :destroy, as: "destroy"
  end
  resources :registrations

  root to: 'home#index'
end
