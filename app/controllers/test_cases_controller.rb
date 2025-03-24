class TestCasesController < ApplicationController
  def self.show_in_navbar? = true

  def index
    @test_cases = TestCase.where(id: current_user.projects.pluck(:id))
  end

  def new; end

  def create
    test_case = TestCase.new(params.permit(%i[title steps expected_result requirement test_module test_data
                                              postconditions priority_id project_id]))

    return unless test_case.save

    render json: { test_case: test_case.as_json }
  end
end
