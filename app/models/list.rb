class List < ApplicationRecord

  #Userとのとの関連性は 多対1なので belengs_to の関係
  belongs_to :user 
  #cardモデルとのアソシエーションを記入 1対多の関係 多数に結びつく時は「複数形」！！にする間違えやすいポイント！！  なお、listが消えたら消えたらカードも消える
  has_many :cards, dependent: :destroy

  #リストのタイトルは255文字までとする
  validates :title, length: {in: 1..255}

end
