Rails.application.routes.draw do
  root 'polls#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  get 'my_polls', to: 'polls#my_polls'
  get 'voted_polls', to: 'polls#voted_polls'
  
  resources :users
  
  resources :polls do
    resources :votes, only: [:create]
    post 'close', on: :member
  end
end
