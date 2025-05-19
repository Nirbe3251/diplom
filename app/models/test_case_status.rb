class TestCaseStatus < ApplicationRecord
  belongs_to :test_case, foreign_key: :test_case_id
  belongs_to :release
end
