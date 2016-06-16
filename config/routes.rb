Rails.application.routes.draw do
  get 'users/new'

  # get 'static_pages/home'
  
  # 0616 Lesson7 4.1 コントローラとルートの作成
  # 0616 Lesson7 6.2 ルートの作成
  # set "app/views/static_pages/home.html.erb" as the top page.
  root to: 'static_pages#home'
  get 'signup',  to: 'users#new'

  resources :users
end
