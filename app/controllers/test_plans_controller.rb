class TestPlansController < ApplicationController
  before_action :find_test_plan, only: %i[show update destroy edit]

  def index
    @test_plans = TestPlan.all
  end

  def show; end

  def edit; end

  def new; end

  def create
    test_plan = TestPlan.new(params.permit(test_plan_params))

    if test_plan.save
      redirect_to test_plan_path(id: test_plan.id)
    else
      render json: { error: test_plan.errors.full_messages.join(', ') }
    end
  end

  def update
    if @test_plan.update(params.permit(test_plan_params))
      redirect_to test_plan_path, action: :edit
    else
      redirect_back(fallback_location: test_plan_path)
    end
  end

  def destroy
    if @test_plan.destroy
      redirect_to test_plans_path
    else
      redirect_back(fallback_location: test_plan_path)
    end
  end

  def self.humanize
    'Планы тестирования'
  end

  private

  def test_plan_params
    %i[title purpose features_to_be_tested features_not_to_be_tested test_strategy test_approach criteria resources
       test_schedule roles_and_responsibility risk_evaluation documentation metrics]
  end

  def find_test_plan
    @test_plan = TestPlan.find_by(id: params[:id])
  end
end
