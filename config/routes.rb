Rails.application.routes.draw do
  root 'homes#index'

  get '/login', to: 'homes#login'
  post '/login', to: 'homes#create_login'
  get '/logout', to: 'homes#logout'
  post '/update_company_details', to: 'homes#update_company_details'
  get '/security', to: 'homes#security'

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
