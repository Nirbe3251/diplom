class TestCase < ApplicationRecord
  self.primary_key = :id
  belongs_to :project

  before_create { generate_uniq_id }

  private

  def generate_uniq_id
    last_id = TestCase.last&.id
    last_id = last_id&.sub('tc', '')
    self.id = "tc#{last_id.to_i + 1}"
  end
end
