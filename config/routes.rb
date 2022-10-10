Rails.application.routes.draw do
  root 'homes#index'

  resources :customers
  resources :items
  resources :orders do
    member do
      get :export
    end
    collection do
      get :customer_search
      get :item_search
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  
end
