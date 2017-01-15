class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def account
  end

  def addresses
    @addresses = current_user.addresses
  end

  def change_account
    @user = current_user
  end

  def update_account
    @user = current_user

    respond_to do |format|
      if @user.update_attributes(user_params)
        format.html { redirect_to users_account_url }
      else
        format.html {}
      end
    end
  end

  def orders
    @orders = current_user.orders
  end

  private

  def user_params
    params.require(:user).permit(:name, :phone)
  end

end
