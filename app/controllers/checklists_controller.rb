class ChecklistsController < ApplicationController
  before_action :find_checklist, only: %i[show edit update]

  def self.show_in_navbar? = true

  def index
    @checklists = Checklist.where(id: current_user.projects.pluck(:id))
  end

  def show; end
  def edit; end

  def create
    checklist = Checklist.new(params.permit(check_list_params))
    return unless checklist.save

    render json: { checklist: }
  end

  def update
    @checklist.update(params.require(:checklist).permit(check_list_params))
  end

  private

  def find_checklist
    @checklist = Checklist.find(params[:id])
  end

  def check_list_params
    %i[head checklist expected_result test_module test_type project_id]
  end
end
