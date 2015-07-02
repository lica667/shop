class AdminController < ApplicationController
  before_action :authenticate_admin!

  def index
    # @session_info = session
  end
  
end