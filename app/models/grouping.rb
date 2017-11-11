class Grouping < ApplicationRecord
  belongs_to :lunch_group
  has_many :grouping_employees

  has_many :employees, through: :grouping_employees
end
