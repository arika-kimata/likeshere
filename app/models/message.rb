class Message < ApplicationRecord
  # バリデーション
  validates :text, presence: true

  # アソシエーション
  belongs_to :user
  belongs_to :hobby
end
