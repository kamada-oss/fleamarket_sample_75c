Rails.application.routes.draw do
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
  resources :mypage, only: [] do
    member do
      get 'good_index'
      get 'item_exhibiting'
      get 'item_sold'
      get 'item_purchased'
      get 'edit_profile'
      post 'update_profile'
      get 'edit_address'
      post 'update_address'
      get 'edit_payment'
      get 'edit_email_password'
      post 'update_email_password'
      get 'logout'
    end
  end
end
