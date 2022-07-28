Rails.application.routes.draw do
  resources :bills
  resources :staffs
  resources :shelves
  resources :users
  resources :books do
    collection do
      get "get_self_borrow_list"
    end
    member do
      put "borrow"
      get "returning_book"
      put "update_return"
    end
  end
  root "books#index"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get "/information", to: "users#information"
end
