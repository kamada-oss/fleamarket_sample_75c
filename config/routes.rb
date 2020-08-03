Rails.application.routes.draw do
  root 'items#index'
  resources :items, only: [:index, :new, :create, :edit, :update] do
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
    end
  end
end
