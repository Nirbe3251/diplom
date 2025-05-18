class TestCasesController < ApplicationController
  before_action :find_test_case, only: %i[show edit update destroy]

  before_action :find_test_suite, only: %i[new test_suites show create update destroy edit]

  def self.show_in_navbar? = true

  def index
    @test_suites = TestSuite.all
  end

  def create_test_suites
    test_suites = TestSuite.new(params.permit(test_suites_params))
    if test_suites.save
      render js: 'window.location.reload();'
    else
      render json: { error: test_suites.errors.full_messages.join(', ') }
    end
  end

  def test_suites
    @test_cases = TestCase.where(project_id: current_user.projects.pluck(:id)).where('test_module LIKE ?',
                                                                                     "%#{@test_suite.title}%").search(params)
  end

  def new; end

  def create
    test_case = TestCase.new(params.permit(test_case_params))

    if test_case.save
      redirect_to show_test_case_path(id: @test_suite.id, test_case_id: test_case.id)
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
      redirect_to test_suite_path
    else
      flash[:error] = @test_case.errors.full_messages.join(', ')
      redirect_back(fallback_location: edit_test_case_path(test_case_id: @test_case.id, id: @suite.id))
    end
  end

  def self.humanize
    TestCase.humanize + 'ы'
  end

  private

  def find_test_case
    @test_case = TestCase.find_by(id: params[:test_case_id])
  end

  def test_case_params
    %i[title steps expected_result requirement test_module test_data
                                              postconditions priority_id project_id id]
  end

  def find_test_suite
    @test_suite = TestSuite.find_by(id: params[:id])
  end

  def test_suites_params
    %i[title]
  end
end
