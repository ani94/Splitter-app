Rails.application.routes.draw do
  #Root
  root 'sessions#new'

  #Session Routes
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  get 'logout' => 'sessions#destroy'

  #Users Routes
  resources :users
  resources :groups
  resources :transactions

  #Additional group routes
  get 'group/:id/add_users' => 'groups#add_users'
  get 'group/:id/add_transaction' => 'groups#add_transaction'
  post 'group/:id/simplify_debts' => 'groups#simplify_debts'

end
