class Currency < ActiveRecord::Base

  after_update :update_goods_costs

  def update_goods_costs
    Good.all.each{ |good| good.update_attributes(
      cost_usd: (good.cost_eur * Currency.first.eur_to_usd).round(2),
      cost_byr: (good.cost_eur * Currency.first.eur_to_usd * Currency.first.usd_to_byr).round(-3))
    }
  end

end
