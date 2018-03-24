Rails.application.routes.draw do
  root to: 'questions#index'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users

  resources :categories, only:[:index,:show]
  resources :questions do 
  	resources :answers, only:[:create,:update,:destroy] 
  end
end
