class AddValdatimeToDataval < ActiveRecord::Migration
  def change
    add_column :datavals, :valdatime, :datetime
  end
end
