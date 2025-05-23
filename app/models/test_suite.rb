class TestSuite < ApplicationRecord
  validates :title, presence: true
  validates :title, uniqueness: true

  after_destroy do
    TestCase.where(test_module: title).destroy_all
  end
end
