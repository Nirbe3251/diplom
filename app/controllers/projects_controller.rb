class ProjectsController < ApplicationController
  before_action :find_project, only: %i[show add_users edit update]

  def self.show_in_navbar?
    true
  end

  def self.page_head
    'Projects'
  end

  def index
    @projects = Project.all
  end

  def edit; end

  def show; end

  def new; end

  def update
    if @project.update(params.require(:project).permit(project_params))
      render json: { status: 'ok', project: @project }, status: 200
    else
      render json: { status: 'error' }, status: 500
    end
  end

  def create
    @project = Project.new(params.permit(project_params))
    @project.user_id = current_user.id
    if @project.save
      redirect project_path(id: @project.id)
    else
      render json: { error: true }
    end
  end

  def add_users
    @project.users << User.where(id: params[:user_ids])
  end

  def delete; end

  private

  def find_project
    @project = Project.find(params[:id])
  end

  def project_params
    %i[title description start_at end_at]
  end
end
