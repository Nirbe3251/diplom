class ChecklistsController < ApplicationController
  def self.show_in_navbar? = true

  def index; end

  def create
    checklist = CheckList.new(params.permit(%i[head checklist expected_result test_module test_type]))
    return unless checklist.save

    render json: { checklist: }
  end
end
