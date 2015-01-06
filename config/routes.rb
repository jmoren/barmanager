BarManager::Application.routes.draw do


  resources :shifts do
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
    resources :item_tickets
  end

  root to: "home#index"
end
