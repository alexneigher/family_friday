class CreateGroupingEmployees < ActiveRecord::Migration[5.1]
  def change
    create_table :grouping_employees do |t|
      t.references :grouping, foreign_key: true
      t.references :employee, index: true
      t.timestamps
    end
  end
end
