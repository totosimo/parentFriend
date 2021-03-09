Rails.application.routes.draw do
  get 'bookings/index'
  get 'bookings/show'
  get 'bookings/destroy'
  get 'bookings/update'
  get 'bookings/edit'
  get 'bookings/new'
  get 'bookings/create'
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
