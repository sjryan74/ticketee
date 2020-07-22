Rails.application.routes.draw do
  namespace :admin do
    root 'application#index'

    resources :projects, only: [:new, :create, :destroy]
    resources :states, only: [:index, :new, :create] do
      member do
        get :make_default
      end
    end
    
    resources :users do
      member do
        patch :archive
      end
    end
  end

  devise_for :users

  root "projects#index"

  resources :projects, only: [:index, :show, :edit, :update] do
    resources :tickets do
      member do
        patch :watch
      end
    end
  end

  scope path: "tickets/:ticket_id", as: :ticket do
    resources :comments, only: [:create]
  end
end
