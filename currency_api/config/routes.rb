Rails.application.routes.draw do
  post '/convert',to: 'currency#convert'
end
