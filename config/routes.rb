Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get '/main', to: 'pages#main'
  get '/meet', to: 'pages#meet'
  post '/meet', to: 'pages#update_location'
  resources :users, only: [:index, :show]
  resources :chatrooms, only: [:index, :show, :create] do
    resources :messages, only: [:create]
  end
  
  resources :events do
    resources :bookings, only: [:new, :create]
  end

  resources :bookings, only: [:index, :show, :destroy, :update, :edit]
end
