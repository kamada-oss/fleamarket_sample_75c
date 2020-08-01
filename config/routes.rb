Rails.application.routes.draw do
  root 'items#index'
  resources :items, only: [:index, :new] do
    collection do
      get 'purchase'
    end
  end
end