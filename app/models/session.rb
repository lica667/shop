# == Schema Information
#
# Table name: sessions
#
#  id         :integer          not null, primary key
#  session_id :string(255)      not null
#  data       :text
#  created_at :datetime
#  updated_at :datetime
#

class Session < ActiveRecord::Base
	has_one :cart
end
