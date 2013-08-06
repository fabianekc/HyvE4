class AddLogincntToUsers < ActiveRecord::Migration
  def change
    add_column :users, :logincnt, :integer, default: 1
  end
end
