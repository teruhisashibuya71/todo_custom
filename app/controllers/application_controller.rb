class ApplicationController < ActionController::Base
  #全てのコントローラーに共通する点はこのファイルに書いておく
  
  #セキュリティに関する記述CSRF クロスサイトリクエストフォージェリ対策
  protect_from_forgery with: :exception
  #ログインしていない場合はsign_in画面へ ログアウトした時もsign_in画面へ
  before_action :authenticate_user!
  #before_action :メソッド名, 条件 
  before_action :configure_permitted_parameters, if: :devise_controller?

  #同一クラス内のメソッドメソッドやインスタンスからは呼び出し可能なメソッド
  protected

  #deviseに名前パラメータも受け取れるようにストロングパラメーターを設定する
  #nameカラムに値を新規入力または更新するメソッド
  def configure_permitted_parameters
    #新規登録画面でnameカラムの取り扱いを許可する
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    #アカウント情報更新画面でnameカラムの取り扱いを許可する
    #画像のアップロードもできるようにimageカラムも加える
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :image])
  end
  

end
