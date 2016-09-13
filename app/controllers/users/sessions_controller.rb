class Users::SessionsController < Devise::SessionsController
  skip_action_callback :authenticate_user!, only: [:new, :create]

  def new
    super
  end
end
