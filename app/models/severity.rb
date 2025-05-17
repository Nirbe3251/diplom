class Severity < ApplicationRecord
  enum severity_level: { blocker: 0, critical: 1, major: 2, minor: 3, trivial: 4 }
end
