class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_cart
  
  protected
  def set_cart
    current_user ||= Session.find_by(session_id: session.id)
    @cart = current_user.try(:cart) || current_user.build_cart(currency:'BY')
  end
end
