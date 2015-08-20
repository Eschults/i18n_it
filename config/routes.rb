Rails.application.routes.draw do
  devise_for :users

  resources :companies, only: :index do
    resources :projects, only: :index
  end
  resources :projects, only: [:edit, :update] do
    resources :buckets, only: [:index, :new, :create ]
  end
  resources :buckets, only: [:edit, :update] do
    resources :translations, only: :index
  end
end
