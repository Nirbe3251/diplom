class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def self.show_in_navbar?
    false
  end

  def self.page_head
    'Введите название заголовка'
  end

  def index
    render json: { message: 'Welcome!' }, status: :ok
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name surname])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[nickname birthday avatar])
  end
end
