class RolesController < ApplicationController
  before_action :find_role, only: %i[destroy update]

  def self.show_in_navbar? = false

  def index
    @roles = Role.all
  end

  def update
    Rails.logger.info params.permit(role_params)
    render 'replace_roles' if @role.update(params.permit(role_params))
  end

  def create
    role = Role.new(params.permit(role_params))

    if role.save
      render 'replace_roles'
    else
      response = {}
      errors = role.errors.objects
      errors.each { |e| response[e.attribute] = e.message }
      Rails.logger.info response
      render 'validates/forms', locals: { errors: response.to_json }
    end
  end

  def destroy
    if @role.destroy
      render 'replace_roles'
    else
      render js: 'alert("error !")'
    end
  end

  def self.humanize
    name = Role.humanize
    name[-1] = 'и'
    name
  end

  private

  def find_role
    @role = Role.find(params[:id])
  end

  def role_params
    %i[name create_test_case create_check_list create_test_plan create_bug_report edit_test_case edit_checklist
       edit_test_plan edit_bug_report remove_test_case remove_checklist remove_test_plan remove_bug_report]
  end
end
