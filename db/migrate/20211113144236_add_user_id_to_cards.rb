class AddUserIdToCards < ActiveRecord::Migration[6.0]
  def change

    #既存のテーブルに外部キーとなるカラムを追加する場合は add_columnで記述できる
    # 親モデルの名前_idとすることで自動的に結びつけてくれる すごい
    # :テーブル名, :追加するカラム名, :型
    #書き終わったらしっかり rails db:migrateしてね
    add_column :cards, :user_id, :integer

  end
end
