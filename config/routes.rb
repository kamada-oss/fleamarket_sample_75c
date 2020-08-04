Rails.application.routes.draw do
  root 'items#index'
  resources :items, only: [:index, :new, :create, :show, :edit, :update] do
    collection do
      get 'search_child', defaults: { format: 'json' }
      get 'search_grandchild', defaults: { format: 'json' }
    end
    namespace :items do
      resources :searches, only: [:index, :show, :new]
    end
  end

  resources :categories, only: [:index, :new, :edit] do
    member do
      get 'parent'
      get 'child'
      get 'grandchild'
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
