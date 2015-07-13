class AdminController < ApplicationController
  before_action :authenticate_admin!

  def index
    if params[:token] == 'currencies'
      render json: {
        'currency_eur_to_usd' => Currency.first.eur_to_usd,
        'currency_usd_to_byr' => Currency.first.usd_to_byr.to_i
      }
    end
    @currency_eur_to_usd = Currency.first.eur_to_usd
    @currency_usd_to_byr = Currency.first.usd_to_byr
    # @session_info = session
  end
  
end