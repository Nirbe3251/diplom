class TestCase < ApplicationRecord
  self.primary_key = :id
  belongs_to :project

  has_many :test_case_status, class_name: 'TestCaseStatus'

  before_create { generate_uniq_id }

  def self.search(params)
    res = all

    if params[:name].present?
      res = res.where('test_cases.id like ? OR test_cases.title like ?', "%#{params[:name]}%",
                      "%#{params[:name]}%")
    end

    res
  end

  def self.find_bigger_id
    all = TestCase.all
  end

  private

  def generate_uniq_id
    uid = TestCase.all.pluck(:id)
    uid = uid.sort_by { |el| el&.sub!('tc-', '').to_i }
    self.id = "tc-#{uid.last.to_i + 1}"
  end
end
