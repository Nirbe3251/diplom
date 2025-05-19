class ReleasesController < ApplicationController
  before_action :find_release, only: %i[show get_chart_data]

  def index
    @releases = Release.all.where(project_id: current_user.projects.pluck(:id))
  end

  def self.humanize
    'Релизы'
  end

  def create
    release = Release.new(params.permit(release_params))

    if release.save
      redirect_to release_path(id: release.id)
    else
      render json: { error: true }
    end
  end

  def show; end

  def get_chart_data
    test_cases_params = params.permit(releases_chart_params)[:test_cases].as_json
    Rails.logger.info "Params #{test_cases_params}"
    tests_size = test_cases_params.size
    completed_cases = test_cases_params.select { |_, v| v == 'completed' }.size

    Rails.logger.info "Completed casess siz: #{completed_cases}"
    test_cases_params.each do |k, v|
      tc = TestCase.find_by(id: k)
      Rails.logger.info "tc id: #{tc.id}"
      next unless tc.present?

      completed = v == 'completed'
      status = TestCaseStatus.where('test_case_id = ?', tc.id).find_by(release_id: @release.id)
      Rails.logger.info "Status: #{status.inspect}"
      if status.present?
        status.update(completed:)
      else
        TestCaseStatus.create(test_case_id: tc.id, release_id: @release.id, completed:)
      end
    end

    data = [{ data: [['Пройдено', completed_cases], ['провалено', tests_size - completed_cases]], name: 'Test cases', type: 'pie',
              colors: %w[#99FF99 #E4717A] }]

    render json: data
  end

  private

  def release_params
    %i[name project_id]
  end

  def find_release
    @release = Release.find_by(id: params[:id])
  end

  def releases_chart_params
    [test_cases: {}]
  end
end
