Rails.application.routes.draw do
  devise_for :users
  root "invoices#index"

  resources :invoices, only: [:index, :new, :create, :show]
end
