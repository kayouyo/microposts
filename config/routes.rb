Rails.application.routes.draw do
  # get 'static_pages/home'
  
  # 0616 Lesson 4.1 コントローラとルートの作成
  root to: 'static_pages#home'
  # set "app/views/static_pages/home.html.erb" as the top page.
end
