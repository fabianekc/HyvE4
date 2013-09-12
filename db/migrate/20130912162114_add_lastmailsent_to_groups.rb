class AddLastmailsentToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :lastmailsent, :datetime
  end
end
