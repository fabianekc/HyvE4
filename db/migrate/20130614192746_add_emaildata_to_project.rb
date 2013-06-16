class AddEmaildataToProject < ActiveRecord::Migration
  def change
    add_column :projects, :emaildata, :boolean
  end
end
