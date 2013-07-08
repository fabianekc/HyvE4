class CreateInvites < ActiveRecord::Migration
  def change
    create_table :invites do |t|
      t.string :name
      t.string :email
      t.text :bio
      t.text :reason
      t.boolean :process

      t.timestamps
    end
  end
end
