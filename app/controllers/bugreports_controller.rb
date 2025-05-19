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
    permitted_params = params.permit(bugreport_params)
    attachments = permitted_params.delete(:attachments)

    bugreport = Bugreport.new(permitted_params)

    if bugreport.save
      Attachment.save_attachments(attachments, bugreport_id: bugreport.id)
      render js: "window.location.replace('#{bugreport_path(id: bugreport.id)}')"
    else
      response = {}
      errors = bugreport.errors.objects
      errors.each { |e| response[e.attribute] = e.message }
      render 'validates/forms', locals: { errors: response.to_json }
    end
  end

  def update
    if @bugreport.update(params.permit(bugreport_params))
      redirect_to bugreport_path(id: @bugreport.id)
    else
      response = {}
      errors = resource.errors.objects
      errors.each { |e| response[e.attribute] = e.message }
      render 'validates/forms', locals: { errors: response.to_json }
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
    default = %i[title description full_description steps environment comment project_id severity_id priority_id status_id
                 performer_id]
    default.append({ attachments: [] })
    default
  end
end
