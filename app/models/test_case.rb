class TestCase < ApplicationRecord
  enum priority: { low: 0, normal: 1, high: 2 }
  belongs_to :project
end
