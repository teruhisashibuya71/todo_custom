class CreateCards < ActiveRecord::Migration[6.0]
  def change
    create_table :cards do |t|

      #カラムは title→string   memo→   list→references 外部キー
      t.string :title, null: false, limit: 255
      t.string :memo,  limit: 1000
      t.references :list, null: false, foreign_key: true

      t.timestamps
    end
  end
end
