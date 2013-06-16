class CreateStructures < ActiveRecord::Migration
  def change
    create_table :structures do |t|
      t.string :name
      t.integer :group_id

      t.timestamps
    end
    add_index :structures, [:group_id]
  end
end
