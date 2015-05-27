class Category < ActiveRecord::Base
  has_many :categories, class_name: "Category", foreign_key: "category_id", dependent: :destroy 
  belongs_to :category, class_name: "Category"

  has_many :good_categories
  has_many :goods, through: :good_categories

  scope :root, -> { where('category_id IS NULL') }
  scope :children, -> { where('category_id IS NOT NULL') }
end
