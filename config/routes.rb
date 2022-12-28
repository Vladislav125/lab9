Rails.application.routes.draw do
  root 'example#input'
  post 'example/show', as: 'show'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
