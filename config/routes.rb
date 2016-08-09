Rails.application.routes.draw do
  concern :commonable do
    collection do
      post :import
      get :download
      get :truncate
    end
  end

  resources :stocks, only: [:index, :new], concerns: :commonable
  resources :purchases, only: [:index, :new], concerns: :commonable

  resources :reports, only: [:index, :new], concerns: :commonable do
    collection do
      get :signout
    end
  end

  root 'reports#index'
end
