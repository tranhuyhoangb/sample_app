Rails.application.routes.draw do
  scope"(:locale)",locale:/en|vi/ do
    root "static_pages#home"

    get "users/new"
    get "help", to: "static_pages#help"
    get "home", to: "static_pages#home"
    get "contact", to: "static_pages#contact"
    get "about", to: "static_pages#about"
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
