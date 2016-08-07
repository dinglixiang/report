Rails.application.routes.draw do
  resources :reports do
    collection do
      post :import
      get :download
      get :truncate
    end
  end

  root 'dashboard#index'
end
