Rails.application.routes.draw do
  resources :projects do
    resources :donations
    resources :discounts
  end

  root "projects#index"
end