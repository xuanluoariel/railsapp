class AddStatusToBasics < ActiveRecord::Migration
  def change
    add_column :basics, :buildingType, :string
    add_column :basics, :buildingId, :integer
    add_column :basics, :buildingArea, :integer
  end
end
