class ProjectsController < ApplicationController
  before_action :find_project, only: %i[show add_users]

  def self.show_in_navbar?
    true
  end

  def self.page_head
    'Projects'
  end

  def index
    @projects = Project.all
  end

  def show; end

  def new; end

  def create
    @project = Project.new(params.permit(%i[title start_at description end_at]))
    @project.user_id = current_user.id
    return unless @project.save

    render plain: 'ok'
  end

  def add_users
    @project.users << User.where(id: params[:user_ids])
  end

  private

  def find_project
    @project = Project.find(params[:id])
  end
end
