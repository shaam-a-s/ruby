Rails.application.routes.draw do
  get '/ssn',to: "hello#ssn"
  get '/snu',to: "hello#snu"
end
