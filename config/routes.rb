Rails.application.routes.draw do
  
  # namespace :public do
  #   get 'orders/new' => 'orders#new'
  #   get 'orders/index'
  #   get 'orders/show'
  #   get 'orders/thanks'
    
  # end
  
  # 管理者用
# URL /admin/sign_in ...
  root to: 'public/homes#top'
  get 'about' => 'public/homes#about'
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: 'admin/sessions'
  }


# 顧客用
# URL /customers/sign_in ...
 devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions',
   passwords: 'customers/passwords'
  }
  
  
    # customer側ルーティング
  # devise_for :customers, controllers: {
  #  sessions:      'customers/sessions',
  #  passwords:     'customers/passwords',
  #  registrations: 'customers/registrations'
  # }

  # 会員側のルーティング設定
  scope module: :public do
   get '/customers/my_page' => 'customers#show'
   get '/customers/my_page/edit' => 'customers#edit'
   get '/customers/unsubscribe' => 'customers#unsubscribe'
   #get '/addresses' => 'addresses#index',as:'test'
   post '/orders/confirm' => 'orders#confirm'
   #get '/about' => 'items#about'
   get '/orders/thanks' => 'orders#thanks'
   patch 'customers/withdraw' => 'customers#withdraw', as: 'customers_withdraw'
  resources :items, only: [:show, :index]
  resources :genres, only: [:index]
  resources :orders, only: [:create, :new, :index, :show]
  resources :addresses, only: [:index, :create, :destroy, :edit, :update]
  resources :cart_items, only: [:index, :create, :update, :destroy]
   delete 'cart_items' => 'cart_items#all_destroy', as: 'all_destroy'

  end
  # 管理者側のルーティング設定
   namespace :admin do
    root to: 'homes#top'
   resources :items
   resources :genres
   resources :customers
   end
end
