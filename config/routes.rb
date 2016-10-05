BarManager::Application.routes.draw do

  devise_for :users

  resources :clients do
    resources :ticket_payments
  end

  resources :suppliers do
    resources :supplier_tickets
  end

  resources :promotions do
    resources :promotion_items
  end

  resources :expenses, only: [:create, :destroy]

  resources :shifts do
    member do
      put :close
    end
    resources :extractions, only: [:create, :destroy]
  end

  resources :daily_cashes do
    member do
      put :close
    end
  end

  resources :monthly_cashes do
    get :close_month, on: :collection
    member do
      put :close
    end
  end

  resources :statistics, only: [:index]

  resources :categories

  resources :items

  resources :tables do
    collection do
      get :change
    end
    member do
      put :open
      put :close
    end
  end

  resources :tickets do
    get   :payment_form, on: :member
    patch :move_to, on: :member, as: :change
    patch :unlink_table, on: :member, as: :unlink_table
    patch :unlink_client, on: :member, as: :unlink_client
    patch :close, on: :member, as: :close
    get   :close_ticket, on: :member
    patch :deliver_all_kitchen, on: :member, as: :deliver_all_kitchen
    resources :additionals
    resources :item_tickets do
      put :increase, on: :member
      put :deliver, on: :member
      delete :destroy_all, on: :collection
    end
    resources :promotion_tickets do
      put :increase_delivered, on: :member
      put :increase, on: :member
      delete :destroy_all, on: :collection
    end
  end

  resources :users do
    member do
      get :monthly_detail
    end
  end

  get  '/fiscal_printer/print' => 'fiscal_printer#printer_form', as: 'fiscal_printer_form'
  post '/fiscal_printer/print' => 'fiscal_printer#print', as: :fiscal_print
  post '/fiscal_printer/close' => 'fiscal_printer#close_day', as: :fiscal_close_day
  post '/fiscal_printer/close_shift' => 'fiscal_printer#close_shift', as: :fiscal_close_shift

  get 'kitchen', to: 'kitchen#index'
  get 'kitchen/:ticket_id/show/:item_id/:type', to: 'kitchen#show'
  get 'kitchen/:ticket_id/print_table', as: 'print_table', to: 'kitchen#print_table'
  get 'close_day', to: 'daily_cashes#show_daily_cash'

  get '/home/index', to: 'home#index'
  root to: "home#index"
end
