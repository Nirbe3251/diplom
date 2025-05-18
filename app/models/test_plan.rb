class TestPlan < ApplicationRecord
  belongs_to :project

  validates :title, :purpose, presence: true
end
