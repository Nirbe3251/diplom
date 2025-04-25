class BugreportStats < ApplicationRecord
  self.table_name = 'status_bug_reports'

  enum step: { not_started: 0, started: 1, paused: 2, finished: 3 }
end
