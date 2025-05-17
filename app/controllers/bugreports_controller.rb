class BugreportsController < ApplicationController
  before_action :find_bugreport, only: %i[edit show update destroy]

  def self.show_in_navbar? = true

  def index
    user_projects_id = current_user.projects.pluck(:id)
    @bugreports = Bugreport.where(project_id: user_projects_id)
  end

  def new; end

  def edit; end

  def create
    bugreport = Bugreport.new(params.permit(bugreport_params))

    if bugreport.save
      redirect_to bugreport_path(id: bugreport.id)
    else
      render js: "alert(#{bugreport.errors.full_messages.join(', ')})"
    end
  end

  def update
    if @bugreport.update(params.permit(bugreport_params))
      redirect_to bugreport_path(id: @bugreport.id)
    else
      render json: { error: @bugreport.errors.full_messages.join(', ') }
    end
  end

  def self.humanize
    'Отчеты об ошибках'
  end

  def destroy
    if @bugreport.destroy
      redirect_to bugreports_path
    else
      redirect_back(fallback_location: bugreport_path)
    end
  end

  private

  def find_bugreport
    @bugreport = Bugreport.find_by(id: params[:id])
  end

  def bugreport_params
    %i[title description full_description steps environment comment project_id severity_id priority_id status_id
       performer_id]
  end
end
