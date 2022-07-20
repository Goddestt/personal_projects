Rails.application.routes.draw do
  resources :bills
  resources :computers
  resources :staffs
  resources :shelves
  root "users#index"
  resources :users do
    resources :books
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
