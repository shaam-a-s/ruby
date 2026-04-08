Rails.application.routes.draw do
  resources :resumes
  root "resume#index"
end
