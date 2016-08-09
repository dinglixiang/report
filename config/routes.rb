Rails.application.routes.draw do
  resources :purchases do
    collection do
      post :import
      get :download
      get :truncate
      get :signout
    end
  end

  resources :reports do
    collection do
      post :import
      get :download
      get :truncate
      get :signout
    end
  end

  root 'reports#index'
end
