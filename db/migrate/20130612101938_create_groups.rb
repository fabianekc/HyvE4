class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.integer :project_id

      t.timestamps
    end
    add_index :groups, [:project_id]
  end
end
