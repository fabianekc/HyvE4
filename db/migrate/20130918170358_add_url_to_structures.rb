class AddUrlToStructures < ActiveRecord::Migration
  def change
    add_column :structures, :url, :string
  end
end
