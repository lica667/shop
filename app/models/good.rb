class Good < ActiveRecord::Base
  validates_presence_of :cost
  validates :cost, numericality: { greater_than_or_equal_to: 0.01, message: "Can't believe in this cost" }
  validates_presence_of :name
  validates_presence_of :description

  has_many :good_categories
  has_many :categories, through: :good_categories
end
