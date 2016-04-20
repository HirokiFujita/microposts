Rails.application.routes.draw do
  root to: 'static_pages#home'
  get 'signup',  to: 'users#new'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  #get 'followings', to: 'users#followings'
  #get 'followers', to: 'users#followers'
  #resources :users

  resources :users do
    member do
      get 'followings'
      get 'followers'
    end
  end

#followings_user GET    /users/:id/followings(.:format) users#followings
#followers_user GET     /users/:id/followers(.:format)  users#followers

  resources :sessions, only: [:new, :create, :destroy]
  resources :microposts
  resources :relationships, only: [:create, :destroy]
end

