class User < ApplicationRecord

  #listモデルとのアソシエーションを記述する
  #1対多の関係なので Listに対しては has_many の関係となる
  #dependent(依存)で親が消えたら子も消える  userが消えたらlistも消える
  has_many :lists, dependent: :destroy

  #検索機能要のカスタム userが消えたら cardも消える
  has_many :cards, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable

  #名前の入力を絶対にする validates :カラム名, バリデーション
  #validates :name, :precence => true,...とも書ける シンボルの記法で書くか、一般的なハッシュの記法で書くか
  validates :name, presence: true, length: {maximum: 20}

  #画像のアップロード機能の追加 モデルに対してアップローダーを取り付け
  mount_uploader :image, ImageUploader

end