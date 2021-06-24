class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :encrypted_password, :nickname, :profile])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :encrypted_password])
  end
end
