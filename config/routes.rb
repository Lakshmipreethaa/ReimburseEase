Rails.application.routes.draw do
  get 'reports/index'
  get 'home/index'
  resources :bills
  resources :employees
  resources :departments
  resources :designations

  root "home#index"
end
