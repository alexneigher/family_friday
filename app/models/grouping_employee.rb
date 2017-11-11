class GroupingEmployee < ApplicationRecord
  belongs_to :grouping
  belongs_to :employee
end
