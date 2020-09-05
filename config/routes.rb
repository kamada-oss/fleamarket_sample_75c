Rails.application.routes.draw do
  get 'items/purchase'
  root 'items#index'
  resources :items, only: [:new, :show, :create, :edit, :update, :destroy] do
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
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }
  resources :signup, only: [:index, :create] do
    collection do
      get 'registration_user_information'
      get 'registration_send_address'
      get 'done'
    end
  end

end
