class Good < ActiveRecord::Base
  validates_presence_of :cost_usd#, :cost_eur, :cost_byr
  validates :cost_usd, numericality: { greater_than_or_equal_to: 0.01, message: "Can't believe in this cost" }
  # validates :cost_eur, numericality: { greater_than_or_equal_to: 0.01, message: "Can't believe in this cost" }
  # validates :cost_byr, numericality: { greater_than_or_equal_to: 0.01, message: "Can't believe in this cost" }
  validates_presence_of :name
  validates_presence_of :description

  has_many :good_categories
  has_many :categories, through: :good_categories
  has_many :photos
  accepts_nested_attributes_for :photos, :reject_if => :all_blank, :allow_destroy => true

  scope :available, -> { where(is_available: true) }

  before_save :set_all_categories

  def set_all_categories
    self.category_ids = self.all_categories
  end

  def all_categories
    (self.categories.map(&:parent_ids) + self.category_ids).flatten.uniq
  end

  def price(currency='usd')
    case currency
    when 'usd'
      self.cost_usd.to_f
    when 'eur'
      self.cost_eur.to_f
    when 'byr'
      self.cost_byr.to_f
    else
      self.cost_usd.to_f
    end
  end
end
