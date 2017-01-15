class Order < ActiveRecord::Base
  has_many :cart_items
  belongs_to :user
  belongs_to :address

  enum status: [:accepted, :in_progress, :delivering, :done]

  after_initialize :set_defaults

  default_scope { order(status: :asc) }

  def total
    cart_items.map{|item| item.quantity * item.good.price('BY')}.sum
  end

  def change_state!(status)
    self.status = status
    self.save
  end

  private

  def set_defaults
    self.status = :accepted if status.nil?
  end
end
