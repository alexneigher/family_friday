class CreateGroupings < ActiveRecord::Migration[5.1]
  def change
    create_table :groupings do |t|
      t.references :lunch_group, foreign_key: true

      t.timestamps
    end
  end
end
