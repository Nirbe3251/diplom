# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new
    super
  end

  # POST /resource/sign_in
  # def create
  # super
  # UserStatus.make_online(user)
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
  #   set_flash_message! :notice, :signed_out if signed_out
  #   yield if block_given?
  #   UserStatus.make_offline(resource_name)
  #   respond_to_on_destroy
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
