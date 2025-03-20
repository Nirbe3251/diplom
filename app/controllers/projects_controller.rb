class ProjectsController < ApplicationController
  before_action :find_project, only: %i[show add_user]

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

  def create
    @project = Project.new(params.permit(%i[title user_id start_at]))
    @project.user_id = current_user.id
    return unless @project.save

    render plain: 'ok'
  end

  def add_user
    @project.users << User.find(params[:user_id])
  end

  def find_project
    @project = Project.find(params[:id])
  end
end
