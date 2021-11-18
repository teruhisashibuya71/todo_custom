class Card < ApplicationRecord
    
  #listとの結びつきは 多対1なので belongs_to
  belongs_to :list

  #usetとの結びつきを用意
  belongs_to :user

  #バリデーションを記述する in→OO文字以上OO文字以下  maximum→OO文字まで
  validates :title, length: {in: 1..50}
  validates :memo, length: {maximum: 400}

end