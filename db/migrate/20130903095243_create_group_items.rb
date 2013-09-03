class CreateGroupItems < ActiveRecord::Migration
  def change
    create_table :group_items do |t|
      t.string :groupid
      t.string :groupname
      t.string :itemname
      t.integer :itemtype
      t.string :lang
      t.text :description

      t.timestamps
    end
  end
end
