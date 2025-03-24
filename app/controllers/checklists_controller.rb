class ChecklistsController < ApplicationController
  before_action :find_checklist, only: %i[show]

  def self.show_in_navbar? = true

  def index
    @checklists = Checklist.where(id: current_user.projects.pluck(:id))
  end

  def show; end

  def create
    checklist = Checklist.new(params.permit(%i[head checklist expected_result test_module test_type project_id]))
    return unless checklist.save

    render json: { checklist: }
  end

  private

  def find_checklist
    @checklist = Checklist.find(params[:id])
  end
end
