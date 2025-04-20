class RolesController < ApplicationController
  before_action :find_role, only: %i[destroy update]

  def self.show_in_navbar? = false

  def index
    @roles = Role.all
  end

  def update
    @role.update(params.permit(role_params))
  end

  def create
    @role = Role.new(params.permit(role_params))

    return unless @role.save

    render json: { role: @role.as_json }
  end

  def destroy
    @role.destroy
  end

  private

  def find_role
    @role = Role.find(params[:id])
  end

  def role_params
    %i[name create_test_case create_check_list create_test_plan create_bug_report]
  end
end
