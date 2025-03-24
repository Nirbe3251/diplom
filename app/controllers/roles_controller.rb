class RolesController < ApplicationController
  def self.show_in_navbar? = false

  def index
    @roles = Role.all
  end

  def create
    @role = Role.new(params.permit(%i[name create_test_case create_check_list create_test_plan create_bug_report]))

    return unless @role.save

    render json: { role: @role.as_json }
  end
end
