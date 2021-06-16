class Hobby < ApplicationRecord
  belongs_to :category
  belongs_to :user

  with_options presence: true do
    validates :title, :release_date, :recommended, :synopsis, :category_id, :user_id
  end
  
end
