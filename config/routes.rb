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
    resources :bucket_schemas, only: [:new, :create]
    resources :sub_buckets, only: [:new, :create]
  end
  resources :bucket_schemas, only: [:edit, :update]

  get 'apis/translations', to: "apis#translations"
  get 'apis/t', to: "apis#t"
  get 'apis/tt', to: "apis#tt"
end
