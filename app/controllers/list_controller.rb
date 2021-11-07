class ListController < ApplicationController
    
    #冗長なコードはまとめる before_action :メソッド名 アクション指定
    #set_listメソッドを呼ぶ
    before_action :set_list, only: %i(edit update destroy)
    
    
    #newアクション
    def new
      #画面移動するだけなのでなにも必要ない
      @list = List.new
    end
    
    #createアクション
    def create
      #フォームに入力された情報を引数で受け取り保存する
      @list = List.new(list_params)
      #保存が成功したらリダイレクトでホーム画面へ savedえDBに保存される
      if (@list.save) then
        redirect_to :root
      else
        #保存できなければ リスト作成画面をもう一度
        render action: :new 
      end
    end

    def edit
      #paramsは送られてきたHTTPリクエスト情報をまとめて取得できる GET/list/1 の場合 → paramsには {id: '1'}というハッシュが含まれる
      #{id: '1'}は params[:id]で取得可能(ハッシュのキー指定の記述方法方法である)
      #@list = List.find_by(id: params[:id])
    end

    def update
      #処理はcreateを同じような感じになる updateの時も、もう一度editと同じデータを取得する
      #@list = List.find_by(id: params[:id])
      #取得したデータである@listを上書きする  上書きメソッドの引数はもちろんlist_params(ハッシュ)
      if @list.update_attributes(list_params)
        redirect_to :root
      else
        #保存できなければ edit画面をもう一度表示
        render action: :edit
      end
    end

    def destroy
      @list.destroy
      #トップに戻る
      redirect_to :root        
    end


    private
    #ストロングパラメーターてきなやつ
    def list_params
      #params→フォーム入力値 require→受け取る値のキーを指定 permit→変更を加えるキー merge→ハッシュを統合するメソッドuser情報が必要なので user情報を統合している
      params.require(:list).permit(:title).merge(user: current_user)
    end

    def set_list
      @list = List.find_by(id: params[:id])
    end

end
