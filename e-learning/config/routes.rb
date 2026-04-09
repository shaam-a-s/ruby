Rails.application.routes.draw do
  root "dashboard#index"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  resources :students
  resources :courses
  resources :lessons
  resources :enrollments, only: [ :create ]
  get "/dashboard", to: "dashboard#index"
end
