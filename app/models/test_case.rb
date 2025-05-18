class TestCase < ApplicationRecord
  self.primary_key = :id
  belongs_to :project

  before_create { generate_uniq_id }

  def self.search(params)
    res = all

    if params[:name].present?
      res = res.where('test_cases.id like ? OR test_cases.title like ?', "%#{params[:name]}%",
                      "%#{params[:name]}%")
    end

    res
  end

  private

  def generate_uniq_id
    last_id = TestCase.last&.id
    last_id = last_id&.sub('tc-', '')
    self.id = "tc-#{last_id.to_i + 1}"
  end
end
