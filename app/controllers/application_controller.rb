class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :devise_sign_up_params, if: :devise_controller? 

 private
  def devise_sign_up_params
	devise_parameter_sanitizer.permit(:sign_up,keys:[:attribute, :nickname, :avatar])
  end

end
