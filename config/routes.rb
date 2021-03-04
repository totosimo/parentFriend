Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get '/main', to: 'pages#main'
  post '/main', to: 'pages#update_location'
  resources :chatrooms, only: [:index, :show, :create] do
    resources :messages, only: [:create]
  end
  resources :events
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
