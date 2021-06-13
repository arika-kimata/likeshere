class Hobby < ApplicationRecord
  belongs_to :category
  belongs_to :user
end
