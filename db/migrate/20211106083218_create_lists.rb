class CreateLists < ActiveRecord::Migration[6.0]
  def change
    create_table :lists do |t|
      #listモデルのカラム条件を記述する カラムはtitle と user（外部キー）とする
      #タイトルカラムはnullを禁止
      t.string :title, null: false

      #userカラムは外部キーとする 外部キーにする場合はreferencesにする
      #refeerences型は カラム名 + _idがカラム名になる よって、user_idというカラムができる
      t.references :user, foreign_key: true, nul: false

      t.timestamps
    end
  end
end
