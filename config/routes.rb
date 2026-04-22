Rails.application.routes.draw do
  root to: "cafes#index"

  resources :sessions, only: [:new, :create] do
    collection do
      delete :destroy
    end
  end

  resources :cafes do
    resources :reviews, only: [:create]
  end

  resources :reviews, only: [:edit, :update, :destroy]
end
