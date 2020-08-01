Rails.application.routes.draw do
  root 'items#index'
  resources :signup, only: [:index, :create] do
    collection do
      get 'registration_user_information'
      get 'registration_send_address'
      get 'done'
    end
  end
  resources :items, only: [:index, :new] 
end
