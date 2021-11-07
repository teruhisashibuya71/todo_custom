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




  private 
  #データベースへの値の入力を許可するメソッド
  def card_params
    #permitで3つのカラムを全て変更できるように設定
    params.require(:card).permit(:title, :memo, :list_id)
  end

  def set_card
    @card = Card.find_by(id: params[:id])
  end


end
