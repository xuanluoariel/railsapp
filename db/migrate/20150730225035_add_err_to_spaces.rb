class AddErrToSpaces < ActiveRecord::Migration
  def change
    add_column :movement_behaviors, :isWorking, :integer
    add_column :meetings, :time_range, :text
    add_column :space_categories, :err, :text
    add_column :occupant_categories, :err, :text
  end
end
