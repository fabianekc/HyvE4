class RemoveCategoryFromProject < ActiveRecord::Migration
  def up
    remove_column :projects, :Category
  end

  def down
    add_column :projects, :Category, :String
  end
end
