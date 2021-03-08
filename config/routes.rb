Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get '/main', to: 'pages#main'
  get '/meet', to: 'pages#meet'
  post '/meet', to: 'pages#update_location'
  resources :chatrooms, only: [:index, :show, :create] do
    resources :messages, only: [:create]
  end
  resources :events
end
