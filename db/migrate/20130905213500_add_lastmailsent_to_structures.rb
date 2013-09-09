class AddLastmailsentToStructures < ActiveRecord::Migration
  def change
    add_column :structures, :lastmailsent, :datetime
  end
end
