# == Schema Information
#
# Table name: good_categories
#
#  id          :integer          not null, primary key
#  good_id     :integer
#  category_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class GoodCategory < ActiveRecord::Base

  belongs_to :good
  belongs_to :category

end
