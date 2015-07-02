class Category < ActiveRecord::Base
  require 'category_presenter'
  
  has_many :categories, class_name: "Category", foreign_key: "category_id", dependent: :destroy 
  belongs_to :category, class_name: "Category"

  has_many :good_categories
  has_many :goods, through: :good_categories

  scope :root, -> { where('category_id IS NULL') }
  scope :children, -> { where('category_id IS NOT NULL') }

  def self.category_presenter
    root_categories = Array.new()
    Category.root.each { |c| root_categories <<  CategoryPresenter.new(c).present }
    root_categories
  end

  def all_with_parents(categories, str = "")
    hash = Hash.new()
    categories.each do |cat|
      hash[cat.id] = "#{cat.name} | #{str}"
      puts "id: #{cat.id} | name: #{cat.name} | hash: #{hash}"
      if !cat.categories.empty?
        cat.all_with_parents(cat.categories, cat.name)
      # else
      #   puts "LAST ELEMENT"
      #   hash[cat.id] += "#{cat.name}   "
      end
    end
    return hash
  end
end
