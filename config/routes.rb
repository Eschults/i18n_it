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
  delete 'translations/:id', to: "buckets#destroy_translation", as: :delete_translation

  get 'apis/translations', to: "apis#translations"
  get 'apis/t', to: "apis#t"
  get 'apis/:project_uuid/t', to: "apis#project_translations"
  get 'apis/:project_uuid/tt', to: "apis#project_translations_for_detailed_buckets"
end
