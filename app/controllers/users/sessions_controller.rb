class Users::SessionsController < Devise::SessionsController
  skip_action_callback :authenticate_user!, only: [:new, :create]

  def new
    super
  end

  def after_sign_in_path_for(resource)
    root_path
  end

  def after_sign_out_path_for(resource_or_scope)
    request.referrer || root_path
  end
end
