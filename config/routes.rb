Rails.application.routes.draw do
  resources :sessions, only: [:new, :create] do
    collection do
      get :signout
    end
  end

  concern :commonable do
    collection do
      post :import
      get :download
      get :truncate
    end
  end

  resources :stocks, only: [:index, :new], concerns: :commonable
  resources :purchases, only: [:index, :new], concerns: :commonable

  resources :reports, only: [:index, :new], concerns: :commonable

  root 'reports#index'
end
