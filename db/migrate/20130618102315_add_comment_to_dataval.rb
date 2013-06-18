class AddCommentToDataval < ActiveRecord::Migration
  def change
    add_column :datavals, :comment, :text
  end
end
