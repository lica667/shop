class GoodCategory < ActiveRecord::Base

  belongs_to :good
  belongs_to :category

end
