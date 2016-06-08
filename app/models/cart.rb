class Cart < ActiveRecord::Base
  belongs_to :session
  has_many :cart_items
  accepts_nested_attributes_for :cart_items, allow_destroy: true

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
