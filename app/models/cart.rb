class Cart < ActiveRecord::Base
	belongs_to :session
	has_many :cart_items
end
