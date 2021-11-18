class AddImageToUser < ActiveRecord::Migration[6.0]
  def change
    #userモデルに画像を追加 テーブルに画像カラムを追加 画像はstringらしい
    add_column :users, :image, :string
  end
end
