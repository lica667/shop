# == Schema Information
#
# Table name: carts
#
#  id         :integer          not null, primary key
#  session_id :integer
#  currency   :string(255)
#  status     :string(255)
#  address_id :integer
#  user_id    :integer
#

class Cart < ActiveRecord::Base
  belongs_to :session
  belongs_to :user
  belongs_to :order
  has_many :cart_items
  has_one :address
  accepts_nested_attributes_for :cart_items
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
