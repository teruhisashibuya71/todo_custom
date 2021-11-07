class TopController < ApplicationController

  def index
    #現在のユーザーで作成したlistを全て取得してインスタンス変数に代入する
    @lists = List.where(user: current_user).order("created_at ASC")
  end
  
end
