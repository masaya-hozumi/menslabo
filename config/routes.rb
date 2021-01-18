Rails.application.routes.draw do
  get 'users/new'
  root 'static_pages#home'
  get  '/help',    to: 'static_pages#help'
  get  '/inquiry', to: 'static_pages#inquiry'

  get  '/signup',  to:'users#new'
end
