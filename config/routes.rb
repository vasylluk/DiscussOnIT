Rails.application.routes.draw do
  

  root to: 'pages#index'

  resources :reports ,only:[:new,:create,:index]

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  
  resources :userparams,only:[:show,:edit,:update]
  get "notifications", to: "userparams#notifications", as:"notifications"
  get "notif_delet", to: "userparams#notif_delet",as:"notif_delet"
  post "userparams/:id/user_notif",to:"userparams#user_notif",as:"user_notif"
  get "chosens", to:"questions#chosens",as:"chosens"


  resources :categories, only:[:show]

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

  resources :posts do
    resources :postcomments , only:[:create,:update,:destroy]
  end

  get "/:type/:id/positiv_vote",to: "votes#positiv_vote",as:"positiv_vote"
  get "/:type/:id/negativ_vote",to: "votes#negativ_vote",as:"negativ_vote"

end
