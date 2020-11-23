Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/new', to: 'repositories#new'
  get '/', to: 'technologies#index'

  resources :repositories, only: [:create, :show]
  resources :router, only: :index

  get "/*path", to: "router#index" # how to hook route at end
end
