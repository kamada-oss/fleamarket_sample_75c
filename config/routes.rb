Rails.application.routes.draw do
  get 'card/new'
  get 'card/show'
  get 'card/confirm'
  post 'card/pay'
  get 'items/purchase'
  root 'items#index'
  resources :items, only: [:index, :new, :create, :show, :edit, :update] do
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
  devise_for :users
  resources :signup, only: [:index, :create] do
    collection do
      get 'registration_user_information'
      get 'registration_send_address'
      get 'done'
    end
  end

end
