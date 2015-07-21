class AdminController < ApplicationController
  before_action :authenticate_admin!

  def index

    if params[:token] == 'get_currencies'
      return render json: {
        'currency_eur_to_usd' => Currency.first.eur_to_usd,
        'currency_usd_to_byr' => Currency.first.usd_to_byr.to_i
      }
    end

    if params[:token] == 'set_currencies'
      Currency.first.update_attributes(currencies_params)
      return render json: { status: :ok }
    end
    # @session_info = session
  end

  def update_costs
    if params[:token] == 'usd'
      eur = (params[:value].to_f / Currency.first.eur_to_usd).round(2)
      byr = (Currency.first.usd_to_byr.to_i * params[:value].to_f).round(-3)
      return render json: { eur: eur, byr: byr }
    end

    if params[:token] == 'eur'
      usd = (Currency.first.eur_to_usd.to_f * params[:value].to_f).round(2)
      byr = (Currency.first.usd_to_byr.to_i * usd).round(-3)
      return render json: { usd: usd, byr: byr }
    end

    if params[:token] == 'byr'
      usd = (params[:value].to_f / Currency.first.usd_to_byr.to_i).round(2)
      eur = (Currency.first.eur_to_usd * usd).round(2)
      return render json: { eur: eur, usd: usd }
    end
  end

  private
    def currencies_params
      params.permit(:eur_to_usd, :usd_to_byr)
    end
  
end