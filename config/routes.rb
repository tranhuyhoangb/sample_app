Rails.application.routes.draw do
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
  end
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
