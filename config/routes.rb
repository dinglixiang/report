Rails.application.routes.draw do
  resources :reports do
    collection do
      post :import
      get :download
      get :truncate
      get :signout
    end
  end

  root 'dashboard#index'
end
