class Cart < ActiveRecord::Base
  belongs_to :session
  belongs_to :user
  has_many :cart_items
  has_one :address
  accepts_nested_attributes_for :cart_items, allow_destroy: true
  accepts_nested_attributes_for :address
  accepts_nested_attributes_for :user
  attr_accessor :checkout

  def add_item!(params)
    if item = cart_items.find_by(good_id: params[:good_id])
      item.quantity += params[:quantity].to_i
      item.save
    else
      cart_items.build(params)
    end
    return save
  end

  def total
    cart_items.map{|item| item.quantity * item.good.price(currency)}.sum
  end
end
