class AddCommentToStructure < ActiveRecord::Migration
  def change
    add_column :structures, :comment, :text
  end
end
