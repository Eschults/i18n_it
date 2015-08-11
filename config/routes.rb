Rails.application.routes.draw do
  devise_for :users

  resources :translations
  resources :buckets
end
