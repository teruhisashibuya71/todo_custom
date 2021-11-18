Rails.application.routes.draw do
  
  #サインアップとサインインのルーティングを作っている users/sign_up など自動でURLが設定される
  # userにするべきであった...
  devise_for :users
  
  #topコントローラーのインデックスアクションアクションを指定
  #rootにする場合はurlではなくアクション指定なので # を使う
  root 'top#index'
  
  #検索用のURLとアクションを設定 verb コントローラー名#アクション名
  post 'search', to: 'card#search'

  #listを作るためのルーティングを設定 new画面
  #get 'list/new'
  #post 'list/create'

  #resoucesを使う場合は以下のように書ける resouces コントローラー名
  resources :list, only: %i(new create edit update destroy) do
    #親子関係にある場合は入れ子構造にできる
    #Cardモデルに対しても同様の処理を可能にする
    resources :card, except: %i(index)
  end

end