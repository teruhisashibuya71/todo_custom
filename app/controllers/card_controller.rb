class CardController < ApplicationController
  
  #同じものはまとめる
  before_action :set_card, only: %i(show edit update destroy)

  def new
    #フォーム用に空のインスタンスを用意
    @card = Card.new
    #listとのアソシエーションがあるため、listのインスタンスも必要 id指定で対象のデータを取得 list_id自体はURLのid番号を参考にする find_by(idは→params[リストのid]の値を代入)
    @list = List.find_by(id: params[:list_id])
  end

  def create
    #フォームに入力された値をインスタンス変数へ代入 入力値はHTTPリクエストのハッシュで取得
    @card = Card.new(card_params)
    #保存が上手くいったらrootへ
    if @card.save
      redirect_to :root
    else
      #HTTPリクエスト必要ないのでrender: :アクション名
      render action: :new
    end
  end

  def show
    #set_cardメソッドで@cardインスタンス変数を取得
  end

  def edit
    #set_cardメソッドで@cardインスタンス変数を取得
    #ログインユーザーが作成したリストを全部取得してインスタンス変数へ
    @lists = List.where(user: current_user)
  end

  def update
    #set_cardメソッドで@cardインスタンス変数を取得
    if @card.update_attributes(card_params)
      redirect_to :root
    else
      #HTTPリクエスト必要ないのでrender: :アクション名
      render action: :edit
    end
  end

  def destroy
    #show画面の@cardインスタンスを消し去るだけ
    @card.destroy
    redirect_to :root
  end

  #検索用のメソッド
  def search
    #入力されたキーワードを変数へ
    keyword = params[:keyword]
    #user_idと検索キーワードを元にDBから値を取得
    @search_result_cards = Card.where('user_id = ? and title like?', current_user.id, "%#{keyword}%")
    #現在の出力形式上、Listをもう一度取得する必要あり
    @lists = List.where(user: current_user).order("created_at ASC")
    #検索結果をindex.htmlに表示する
    render "top/index"
  end


  private 
  #データベースへの値の入力を許可するメソッド 基本的に1つのコントローラーに1つは必ず書くことになるはず
  def card_params
    #permitで3つのカラムを全て変更できるように設定
    params.require(:card).permit(:title, :memo, :list_id, :user_id)
  end

  def set_card
    @card = Card.find_by(id: params[:id])
  end

end
