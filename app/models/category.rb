# == Schema Information
#
# Table name: categories
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  category_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#
# Indexes
#
#  index_categories_on_category_id  (category_id)
#

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
    root_categories.join
  end

  def self.all_with_parents
    hash = Hash.new()
    Category.root.each do |cat|
      hash[cat.id] = {"name" => cat.name}
      Category.subcategories_with_breadcrumb(cat.categories, hash[cat.id]["name"], hash) unless cat.categories.empty?
    end
    return hash
  end

  def self.print_categories_with_breadcrumb(good=nil)
    # .map{|c| c << {:checked=>true}}
    if good
      Category.all_with_parents.map{|c| ["#{c.last['name']} #{">>> #{c.last['breadcrumb']}" unless c.last['breadcrumb'].nil?}", c.first, :checked => good.category_ids.include?(c.first)]}
    else
      Category.all_with_parents.map{|c| ["#{c.last['name']} #{">>> #{c.last['breadcrumb']}" unless c.last['breadcrumb'].nil?}", c.first]}
    end
  end

  def parent_ids(ids=nil)
    ids ||= Array.new()
    if self.category
      ids << self.category_id
      self.category.parent_ids(ids)
    end
    ids
  end

  def parents
    Category.find(self.parent_ids)
  end

  private

  def self.subcategories_with_breadcrumb(categories, path, hash)
    categories.each do |cat|
      hash[cat.id] = {"name" => cat.name, "breadcrumb" => path}
      Category.subcategories_with_breadcrumb(cat.categories, "#{hash[cat.id]['name']} | #{hash[cat.id]['breadcrumb']}", hash) unless cat.categories.empty?
    end
    return hash
  end
end
