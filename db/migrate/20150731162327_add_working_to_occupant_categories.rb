class AddWorkingToOccupantCategories < ActiveRecord::Migration
  def change
    remove_column :space_categories, :err, :text
    remove_column :occupant_categories, :err, :text
    drop_table :users
  end
end
