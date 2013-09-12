class AddNextmailToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :nextmail, :datetime
  end
end
