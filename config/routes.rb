BarManager::Application.routes.draw do

  resources :promotions do
    resources :promotion_items
  end

  resources :shifts do
    member do
      put :close
    end
    resources :expenses, only: [:create, :destroy]
  end

  resources :statistics, only: [:index]

  resources :categories

  resources :items

  resources :tables do
    member do
      put :open
      put :close
    end
  end

  resources :tickets do
    patch :move_to, on: :member, as: :change
    resources :item_tickets do
      put :increase, on: :member
      put :deliver, on: :member
      delete :destroy_all, on: :collection
    end
    resources :additionals
    resources :promotion_tickets do
      put :increase_delivered, on: :member
      put :increase, on: :member
      delete :destroy_all, on: :collection
    end
  end

  get 'kitchen', to: 'kitchen#index'
  get 'kitchen/:ticket_id/show/:item_id/:type', to: 'kitchen#show'

  root to: "statistics#index"
end
