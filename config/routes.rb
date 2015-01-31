BarManager::Application.routes.draw do

  devise_for :users

  resources :users do
    resources :expenses, only: [:create, :destroy]
  end

  resources :promotions do
    resources :promotion_items
  end

  resources :shifts do
    member do
      put :close
    end
    resources :expenses, only: [:create, :destroy]
    resources :extractions, only: [:create, :destroy]
  end

  resources :daily_cashes do
    member do
      put :close
    end
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
    patch :unlink_table, on: :member, as: :unlink_table
    patch :close, on: :member, as: :close
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

  resources :users
  get 'kitchen', to: 'kitchen#index'
  get 'kitchen/:ticket_id/show/:item_id/:type', to: 'kitchen#show'
  get 'close_day', to: 'daily_cashes#show_daily_cash'
  root to: "home#index"
end
