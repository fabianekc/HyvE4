class CreatePjattribs < ActiveRecord::Migration
  def change
    create_table :pjattribs do |t|
      t.integer :project_id
      t.integer :attrtype
      t.string :attrvalue

      t.timestamps
    end
    add_index :pjattribs, [:project_id]
  end
end
