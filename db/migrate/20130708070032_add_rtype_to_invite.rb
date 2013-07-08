class AddRtypeToInvite < ActiveRecord::Migration
  def change
    add_column :invites, :rtype, :string
  end
end
