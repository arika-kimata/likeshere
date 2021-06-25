class Hobby < ApplicationRecord
  # バリデーション

  # タイトル、あらすじ、おすすめポイント
  with_options presence: true do
    validates :title, :synopsis, :recommended, :user_id
  end

  # 公開年月日
  with_options presence: { message: 'が未選択です。' } do
    validates :release_date
  end

  # アソシエーション
  belongs_to :category
  belongs_to :user
  has_many :messages

  def self.search(search)
    if search != ""
      Hobby.where('title LIKE(?)', "%#{search}%")
    else
      Hobby.all
    end
  end

end