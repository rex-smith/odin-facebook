class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def send_welcome_email
    UserMailer.with(user: @user).welcome_email.deliver_now
  end

  def send_request_email
    UserMailer.with(request: @request).request_email.deliver_now
  end

  def ensure_avatar
    @user.set_avatar_default unless @user.avatar.attached?
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name])
  end
  
end
