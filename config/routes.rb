Rails.application.routes.draw do
  
  # 管理者用
# URL /admin/sign_in ...
 root to: 'public/homes#top'
 devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: 'admin/sessions',
  passwords: 'admins/passwords',
  registrations: 'admins/registrations'
  }

# 顧客用
# URL /customers/sign_in ...
 devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions',
   passwords: 'customers/passwords'
  }
  # 会員側のルーティング設定
  scope module: :public do
   get 'customers/my_page' => 'customers#show'
   get '/customers/my_page/edit' => 'customers#edit'
  resources :items, only: [:show, :index]
  resources :genres, only: [:index]

  end
  # 管理者側のルーティング設定
   namespace :admin do
   resources :items
   resources :genres
   resources :customers
   end
end
