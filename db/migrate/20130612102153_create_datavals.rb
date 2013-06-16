class CreateDatavals < ActiveRecord::Migration
  def change
    create_table :datavals do |t|
      t.string :value
      t.integer :structure_id

      t.timestamps
    end
    add_index :datavals, [:structure_id, :created_at]
  end
end
