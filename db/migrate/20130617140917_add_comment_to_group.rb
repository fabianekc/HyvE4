class AddCommentToGroup < ActiveRecord::Migration
  def change
    add_column :groups, :comment, :text
  end
end
