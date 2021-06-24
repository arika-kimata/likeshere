class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # ニックネーム
  validates :nickname, presence: true

  # パスワード
  with_options confirmation: { message: '確認用パスワードとパスワードは一致しないといけません。' },
               format: { with: /(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]/, message: 'は半角英数字混合での入力が必須です。' } do
    validates :password
    validates :password_confirmation, presence: true
  end

  # プロフィール
  validates :profile, presence: true

  # バリデーション
  has_many :hobbies
  has_many :messages
end
