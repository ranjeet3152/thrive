Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'dashboard#index'
  resources :dashboard do
    collection do
      get :upload_users
      get :upload_transactions
    end
  end

  resources :documents do
    collection do
      get :upload_users
      get :upload_transactions
      post :import_user
      post :import_transactions
      get :user_report
      get :transaction_report
      get :filter_data
    end
  end
end
