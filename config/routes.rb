Rails.application.routes.draw do
  get 'reports/index'
  get 'home/index'
  resources :bills
  resources :employees
  resources :departments
  resources :designations
  post 'employees/delete_employee/:id', to: "employees#delete_employee"

  root "home#index"
end
