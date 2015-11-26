Rails.application.routes.draw do
  root 'pages#index'
  # devise_for :users

  resources :games, only: [:index]
  get 'feed' => 'games#feed'
end
