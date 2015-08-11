module GoodsHelper
  def price_helper(cost, currency='usd')
    case currency
    when 'usd'
      number_to_currency(cost, precision:2, delimiter:" ")
    when 'eur'
      number_to_currency(cost, :unit => '&euro;'.html_safe, precision:2, delimiter:" ", format:"%u %n")
    when 'byr'
      number_to_currency(cost, unit: "Br", precision:0, delimiter:" ", format:"%n %u")
    else
      number_to_currency(cost, precision:2, delimiter:" ")
    end
  end
end
