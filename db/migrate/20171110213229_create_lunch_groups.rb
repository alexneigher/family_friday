class CreateLunchGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :lunch_groups do |t|
      t.integer :seed

      t.timestamps
    end
  end
end
