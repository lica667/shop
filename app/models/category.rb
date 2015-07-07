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

  def self.all_with_parents
    hash = Hash.new()
    Category.root.each do |cat|
      hash[cat.id] = {"name" => cat.name}
      puts "id: #{cat.id} | hash: #{hash}"
      if !cat.categories.empty?
        Category.subcategories_with_breadcrumb(cat.categories, hash[cat.id]["name"], hash)
        # str = str.empty? ? "#{cat.name}" : " #{cat.name} +++ #{str} "
        # str += "* #{cat.name} * " " #{cat.name} +++ #{str} "
        # cat.categories.each {|c| c.all_with_parents(cat.categories, str) }
      # else
      #   str = ""
      end
    end
    return hash
  end

  def self.subcategories_with_breadcrumb(categories, path, hash)
    categories.each do |cat|
      hash[cat.id] = {"name" => cat.name, "breadcrumb" => path}
      Category.subcategories_with_breadcrumb(cat.categories, "#{hash[cat.id]['name']} | #{hash[cat.id]['breadcrumb']}", hash) unless cat.categories.empty?
    end
    return hash
  end
end
