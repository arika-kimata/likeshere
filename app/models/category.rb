class Category < ApplicationRecord
  has_many :hobbies
  has_ancestry

  def self.category_parent_array_create
    category_parent_array = ['---']
    Category.where(ancestry: nil).each do |parent|
      category_parent_array << [parent.name, parent.id]
    end
    category_parent_array
  end

  def self.maltilevel_category_create(_category_id, parent_id, children_id, grandchildren_id)
    category = Category.find(parent_id) if parent_id.present? && parent_id != '--'

    category = Category.find(children_id) if children_id.present? && children_id != '--'

    category = Category.find(grandchildren_id) if grandchildren_id.present? && grandchildren_id != '--'
  end
end
