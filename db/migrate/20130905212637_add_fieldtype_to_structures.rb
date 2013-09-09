class AddFieldtypeToStructures < ActiveRecord::Migration
  def change
    add_column :structures, :fieldtype, :integer
  end
end
