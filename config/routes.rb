Rails.application.routes.draw do
  root "invoices#index"

  resources :invoices, only: [:index, :new, :create, :show]
end
