class TestCasesController < ApplicationController
  before_action :find_test_case, only: %i[show edit update]

  def self.show_in_navbar? = true

  def index
    @test_cases = TestCase.where(project_id: current_user.projects.pluck(:id))
  end

  def new; end

  def create
    test_case = TestCase.new(params.permit(test_case_params))

    if test_case.save
      render json: { test_case: test_case.as_json }
    else
      render json: { error: true }
    end
  end

  def show; end

  def update
    @test_case.update(params.permit(test_case_params))
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
