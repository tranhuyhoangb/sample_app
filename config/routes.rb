Rails.application.routes.draw do
  get 'password_resets/new'
  get 'password_resets/edit'
  scope"(:locale)",locale:/en|vi/ do
    root "static_pages#home"

    get "help", to: "static_pages#help"
    get "home", to: "static_pages#home"
    get "contact", to: "static_pages#contact"
    get "about", to: "static_pages#about"
    get "signup", to: "users#new"
    get "login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    resources :users
    resources :account_activations, only: :edit
    resources :password_resets, except: %i(index show destroy)
    resources :microposts, only: %i(create destroy)
  end
end
