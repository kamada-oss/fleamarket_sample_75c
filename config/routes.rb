Rails.application.routes.draw do
  devise_for :users
  root 'items#index'
  resources :signup, only: [:index, :create] do
    collection do
      get 'registration_user_information'
      get 'registration_identification'
      get 'registration_send_address'
    end
  end
end
