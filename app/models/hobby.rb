class Hobby < ApplicationRecord
 # バリデーション

 # タイトル、あらすじ、おすすめポイント
  with_options presence: true do
    validates :title, :synopsis, :recommended, :user_id
  end

 # 公開年月日
  with_options numericality: { greater_than_or_equal_to: 1, message: 'が未選択です。' } do
    validates :release_date
  end

 # アソシエーション
  belongs_to :category
  belongs_to :user
  
end
