class Severity < ApplicationRecord
  enum severity_level: { minor: 0, medium: 1, major: 2, critical: 3 }
end
