Rails.application.routes.draw do
  resources :books do
    member do
      patch :borrow
      patch :return_book
    end
  end
end