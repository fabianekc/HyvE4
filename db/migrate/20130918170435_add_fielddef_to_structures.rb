class AddFielddefToStructures < ActiveRecord::Migration
  def change
    add_column :structures, :fielddef, :string
  end
end
