Rails.application.routes.draw do
  root to: 'homes#top'
  
  # 管理者用
# URL /admin/sign_in ...
 devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
  }

# 顧客用
# URL /customers/sign_in ...
 devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }
  # 会員側のルーティング設定
  scope module: :public do
  get 'items' => 'items#index'
  end
  # 管理者側のルーティング設定
  # namespace :admin do
  # get 'items' => 'admin/items#index'
  # end
  
  # namespace :admin do
  # resources :items
  # end
end
