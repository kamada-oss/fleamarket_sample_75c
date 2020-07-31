Rails.application.routes.draw do
  devise_for :users
  root 'items#index'
  resources :signup, only: [:index, :create] do
    collection do
      get 'registration_user_information'
      get 'registration_send_address'
      get 'done'
    end
  end
end
