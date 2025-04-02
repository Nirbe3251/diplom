class TestCase < ApplicationRecord
  self.primary_key = :id

  enum priority: { low: 0, normal: 1, high: 2 }
  belongs_to :project

  before_create { generate_uniq_id }

  before_save { Rails.logger.info  }

  def generate_uniq_id
    last_id = TestCase.last&.id
    last_id = last_id&.sub('tc', '')
    self.id = "tc#{last_id.to_i + 1}"
  end
end
