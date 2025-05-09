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

    if @role.save
      render 'replace_roles'
    else
      render js: 'alert("error !")'
    end
  end

  def destroy
    if @role.destroy
      render 'replace_roles'
    else
      render js: 'alert("error !")'
    end
  end

  private

  def find_role
    @role = Role.find(params[:id])
  end

  def role_params
    %i[name create_test_case create_check_list create_test_plan create_bug_report]
  end
end
