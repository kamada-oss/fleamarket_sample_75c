Rails.application.routes.draw do
  get 'card/new'
  get 'card/show'
  root 'items#index'
  resources :items, only: [:index, :new, :show] do
    collection do
      get 'purchase'
    end
  end
  devise_for :users
  resources :signup, only: [:index, :create] do
    collection do
      get 'registration_user_information'
      get 'registration_send_address'
      get 'done'
    end
  end
end