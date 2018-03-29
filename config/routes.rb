Rails.application.routes.draw do
  root to: 'questions#index'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  
  resources :categories, only:[:index,:show]

  resources :questions do 
    member do 
      get :chosen
  end

    resources :answers, only:[:create,:update,:destroy] 
  end
  get "answers/:id/positiv_vote", to: "answers#positiv_vote", as:"positiv_vote"
  get "answers/:id/negativ_vote", to: "answers#negativ_vote", as:"negativ_vote"

end
