Rails.application.routes.draw do
  resources :users
  resources :posts do
    resources :tags
  end

  root "users#index"
end