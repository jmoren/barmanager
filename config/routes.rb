BarManager::Application.routes.draw do

  devise_for :users
  
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
    resources :item_tickets
    resources :additionals
    resources :promotion_tickets do
      put :increase, on: :member
    end
  end

  root to: "statistics#index"
end
