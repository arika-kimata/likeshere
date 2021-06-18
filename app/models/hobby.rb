class Hobby < ApplicationRecord
  belongs_to :category
  belongs_to :user

  with_options presence: true do
    validates :title, :recommended, :synopsis, :user_id
  end

  with_options presence: { message: 'が未選択です。' } do
    validates :release_date
    validates :category
  end
  
end
