class TestCase
  enum priority: { low: 0, normal: 1, high: 2 }
  belongs_to :project
  belongs_to :test_module
end
