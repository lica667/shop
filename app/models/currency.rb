# == Schema Information
#
# Table name: currencies
#
#  id         :integer          not null, primary key
#  eur_to_usd :decimal(8, 2)    default(0.0)
#  usd_to_byn :decimal(8, 2)    default(0.0)
#  created_at :datetime
#  updated_at :datetime
#

class Currency < ActiveRecord::Base

  after_update :update_goods_costs

  def update_goods_costs
    Good.all.each{ |good| good.update_attributes(
      cost_usd: (good.cost_eur * Currency.first.eur_to_usd).round(2),
      cost_byn: (good.cost_eur * Currency.first.eur_to_usd * Currency.first.usd_to_byn).round(2))
    }
  end

end
