Rails.application.routes.draw do
  # 0616 13597.2 コントローラとルートの作成 ??delete?? bug?
  # get 'sessions/new'
  # get 'users/new'

  # get 'static_pages/home'
  
  # 0616 Lesson7 4.1 コントローラとルートの作成
  # 0616 Lesson7 6.2 ルートの作成
  # set "app/views/static_pages/home.html.erb" as the top page.
  root to: 'static_pages#home'
  get    'signup', to: 'users#new'
  get    'login' , to: 'sessions#new'
  post   'login' , to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  resources :users
  resources :sessions, only: [:new, :create, :destroy]

  resources :microposts
  resources :relationships, only: [:create, :destroy]

  # define the action of users' get method
  resources :users do
    member do
      get 'followers'
      get 'followings'
    end
  end
   
end
