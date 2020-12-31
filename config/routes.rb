Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # get '/users', to: 'users#index'
  # get '/users/:id', to: 'users#show'
  # # get /user/5  | get /users/banana
  # post '/users', create
  # patch '/users/:id', update
  # delete '/users/:id', destroy
  # resources :users
  # resources :users, only: [:index, :create, :update, :destroy, :show]
  resources :users, except: [:edit, :new]
end
