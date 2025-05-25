class ChecklistsController < ApplicationController
  before_action :find_checklist, only: %i[show edit update destroy]

  def self.show_in_navbar? = true

  def index
    @checklists = Checklist.where(project_id: current_user.projects.pluck(:id))
  end

  def show; end
  def edit; end

  def create
    checklist = Checklist.create_checklist(params.permit(check_list_params))

    if checklist.persisted?
      redirect_to checklist_path(id: checklist.id)
    else
      render json: { checklist_error: checklist.errors.full_messages.join(', ') }
    end
  end

  def update
    if @checklist.update_checklist(params.permit(check_list_params))
      redirect_to checklist_path(id: @checklist.id)
    else
      render json: { errors: @checklist.errors.full_messages.join(', ') }
    end
  end

  def self.humanize
    Checklist.humanize + 'ы'
  end

  def destroy
    if @checklist.destroy
      redirect_to checklists_path
    else
      redirect_back(fallback_location: checklist_path)
    end
  end

  private

  def find_checklist
    @checklist = Checklist.find(params[:id])
  end

  def check_list_params
    [:head, { checklists: {} }, :expected_result, :test_type, :project_id]
  end
end
