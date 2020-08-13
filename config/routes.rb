Rails.application.routes.draw do
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
  resources :mypage, only: [:show, :edit]
end