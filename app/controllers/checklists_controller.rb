class ChecklistsController < ApplicationController
  def self.show_in_navbar? = true

  def index
    @checklists = Checklist.where(id: current_user.projects.pluck(:id))
  end

  def create
    checklist = Checklist.new(params.permit(%i[head checklist expected_result test_module test_type project_id]))
    return unless checklist.save

    render json: { checklist: }
  end
end
