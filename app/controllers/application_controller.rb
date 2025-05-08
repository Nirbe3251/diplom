class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  layout :determine_layout

  def determine_layout
    module_name = self.class.to_s
    if module_name.match?(/(Devise)/) || (module_name.match?(/(RegistrationsController)/) && %w[new
                                                                                                create].include?(action_name))
      'admin'
    else
      'application'
    end
  end

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
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name surname roles_id])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name surname roles_id])
  end
end
