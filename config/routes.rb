Rails.application.routes.draw do
  root to: 'questions#index'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  resources :userparams,only:[:show,:edit,:update]
  get "notifications", to: "userparams#notifications", as:"notifications"
  get "chosens", to:"questions#chosens",as:"chosens"


  resources :categories, only:[:index,:show]

  resources :questions do 
    member do 
      get :chosen
    end
    resources :answers, only:[:create,:update,:destroy] 
    resources :qcomments, only:[:create,:update,:destroy]
  end

  resources :answers, only:[] do
    member do
      get :right
    end
    resources :anscomments, only:[:create,:update,:destroy]
  end

  get "answers/:id/positiv_vote", to: "answers#positiv_vote", as:"positiv_vote"
  get "answers/:id/negativ_vote", to: "answers#negativ_vote", as:"negativ_vote"

<<<<<<< HEAD
=======
  get "questions/:id/qpositiv_vote", to: "questions#positiv_vote", as:"qpositiv_vote"
  get "questions/:id/qnegativ_vote", to: "questions#negativ_vote", as:"qnegativ_vote"

>>>>>>> d8d478cc919bde9fb16fdafd7e6e4d1f63d64487
end
