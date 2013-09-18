class CreateTemplates < ActiveRecord::Migration
  def change
    create_table :templates do |t|
      t.string :templateid
      t.string :name
      t.text :description
      t.string :lang

      t.timestamps
    end
  end
end
