Rails.application.routes.draw do
  devise_for :users

  root to: "companies#index"

  resources :companies, only: [:index, :show] do
    resources :projects, only: [:new, :create]
  end
  resources :projects, only: [:show, :edit, :update] do
    resources :buckets, only: [:new, :create]
  end
  resources :buckets, only: [:edit, :update] do
    resources :translations, only: :index
  end
  get 'apis/translations', to: "apis#translations"
end
