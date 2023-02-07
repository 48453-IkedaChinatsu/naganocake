Rails.application.routes.draw do
  # 会員側のルーティング設定
  scope module: :public do
  get 'items' => 'items#index'
  end
  # 管理者側のルーティング設定
  namespace :admin do
  get 'items' => 'admin/items#index'
  end
  
  namespace :admin do
  resources :items
  end
end
