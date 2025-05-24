class TestSuite < ApplicationRecord
  validates :title, presence: true
  validates :title, uniqueness: true

  after_destroy do
    TestCase.where(test_module: title).destroy_all
  end

  after_update do
    if saved_change_to_title?
      last_title = saved_changes[:title].first
      new_title = saved_changes[:title].last
      TestCase.where(test_module: last_title).update_all(test_module: new_title)
    end
  end
end
