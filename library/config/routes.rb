Rails.application.routes.draw do
  resources :books
  resources :borrowers



  resources :borrowings, only: [:create,:index] do
    member do
      patch :return_book
    end
  end

  root "books#index"
end