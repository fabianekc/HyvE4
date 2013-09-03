class CreateTemplateGroups < ActiveRecord::Migration
  def change
    create_table :template_groups do |t|
      t.string :templateid
      t.string :templatename
      t.string :groupname
      t.string :lang
      t.text :description

      t.timestamps
    end
  end
end
