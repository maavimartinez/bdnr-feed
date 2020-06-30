Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'authentication#login'
  match '/welcome', to: 'authentication#login', via: 'get', as: :home
  post '/auth/login', to: 'authentication#login'
  get '/activities/fill', to: 'activities#fill'
  get '/auth/login', to: 'authentication#show'
  get '/users/new', to: 'users#new' 
  post '/users', to: 'users#create' 
  get '/home', to: 'activities#index'
end
