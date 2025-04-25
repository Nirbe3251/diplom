class Priority < ApplicationRecord
  enum priority_level: { normal: 0, medium: 1, high: 2, higher: 3 }
end
