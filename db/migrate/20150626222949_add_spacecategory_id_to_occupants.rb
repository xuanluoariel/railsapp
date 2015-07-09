class AddSpacecategoryIdToOccupants < ActiveRecord::Migration
  def change
    remove_column :occupants, :SpaceCategory_id, :integer
    add_column :occupants, :space_category_id, :integer
    
  end
end
