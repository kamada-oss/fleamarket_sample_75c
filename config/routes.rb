Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }
  get 'items/purchase'
  root 'items#index'
  
  resources :items, only: [:new, :show, :create, :edit, :update, :destroy] do
    resources :comments, only: [:create, :destroy]
    collection do
      get 'search_child', defaults: { format: 'json' }
      get 'search_grandchild', defaults: { format: 'json' }
      get 'search'
      get 'post_done'
      get 'delete_done'
      get 'update_done'
    end
  end


  resources :categories, only: [:index, :new, :show] do
    member do
      get 'parent'
      get 'child'
      get 'grandchild'
    end
  end
  resources :items, only: [:index, :new, :show] do
    collection do
      get 'purchase'
    end
  end
  resources :signup, only: [:index, :create] do
    collection do
      get 'registration_user_information'
      get 'registration_send_address'
      get 'done'
    end
  end

  resources :card, only: [:new, :show, :create] do
    collection do
      post 'pay', to: 'card#pay'
      post 'delete', to: 'card#delete'
    end
  end

  resources :purchases, only: [:new, :create, :show] do
    member do
      post 'pay', to: 'purchases#pay'
      get 'done', to: 'purchases#done'
    end
  end

end
