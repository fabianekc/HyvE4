class AddInvitecodeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :invitecode, :string
  end
end
