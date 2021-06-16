class Category < ApplicationRecord
  has_many :items
  has_ancestry

  def self.category_parent_array_create
    category_parent_array = ['---']
    Category.where(ancestry: nil).each do |parent|
      category_parent_array << [parent.name, parent.id]
    end
    return category_parent_array
  end

  def self.maltilevel_category_create(parent_id, children_id, grandchildren_id)
    if parent_id.present? && parent_id != '--'
      category = Category.find(parent_id)
    end

    if children_id.present? && children_id != '--'
      category = Category.find(children_id)
    end

    if grandchildren_id.present? && grandchildren_id != '--'
      category = Category.find(grandchildren_id)
    end
  end
end