class TestCasesController < ApplicationController
  before_action :find_test_case, only: %i[show edit update destroy]

  def self.show_in_navbar? = true

  def index
    @test_cases = TestCase.where(project_id: current_user.projects.pluck(:id))
  end

  def new; end

  def create
    test_case = TestCase.new(params.permit(test_case_params))

    if test_case.save
      redirect_to test_case_path(id: test_case.id)
    else
      render json: { error: true }
    end
  end

  def show; end

  def update
    @test_case.update(params.permit(test_case_params))
  end

  def destroy
    if @test_case.destroy
      redirect_to test_cases_path
      flash[:ok] = 'Удален'
    else
      flash[:error] = @test_case.errors.full_messages.join(', ')
      redirect_back(fallback_location: test_cases_path)
    end
  end

  def self.humanize
    TestCase.humanize + 'ы'
  end

  private

  def find_test_case
    @test_case = TestCase.find_by(id: params[:id])
  end

  def test_case_params
    %i[title steps expected_result requirement test_module test_data
                                              postconditions priority_id project_id]
  end
end
