class AdminController < ApplicationController
  before_action :authenticate_admin!

  def index
    # case params[:token]

    # when params[:token] == 'get_currencies'
    #   render json: {
    #     'currency_eur_to_usd' => Currency.first.eur_to_usd,
    #     'currency_usd_to_byr' => Currency.first.usd_to_byr.to_i
    #   }

    # when params[:token] == 'set_currencies'
    #   Currency.first.update_attributes(currencies_params)
    #   render json: { status: :ok }

    # end


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

  private
    def currencies_params
      params.permit(:eur_to_usd, :usd_to_byr)
    end
  
end