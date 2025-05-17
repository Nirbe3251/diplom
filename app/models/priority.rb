class Priority < ApplicationRecord
  enum priority_level: { low: 0, medium: 1, high: 2, asap: 3 }
end
