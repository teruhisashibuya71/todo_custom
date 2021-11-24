Rails.application.routes.draw do
  
  #サインアップとサインインのルーティングを作っている users/sign_up など自動でURLが設定される
  #usersフォルダ配下のコントローラーを使用するように指定してルーティングを変える 対応するコントローラーを変えている
  # Prefix→OO系は: "OOディレクトリの/OOコントローラーを対応させる  という意味
  #
  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations",
  }
  #users/registrations系にshow画面へのrouteingを追加
  #userモデル用のコントローラーのshowアクションを割り当てるために必要な処理
  devise_scope :user do
    get "/users/show", to: "users/registrations#show"
  end

  
  
  
  #topコントローラーのインデックスアクションアクションを指定
  #rootにする場合はurlではなくアクション指定なので # を使う
  root 'top#index'
  
  #検索用のURLとアクションを設定 「verb 'prefix', to: 'コントローラー名#アクション名'」
  post 'search', to: 'card#search'

  #resoucesを使う場合は以下のように書ける resouces コントローラー名
  resources :list, only: %i(new create edit update destroy) do
    #親子関係にある場合は入れ子構造にできる
    #Cardモデルに対しても同様の処理を可能にする
    resources :card, except: %i(index)
  end

end