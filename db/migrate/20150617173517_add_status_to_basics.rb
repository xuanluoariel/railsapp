class AddStatusToBasics < ActiveRecord::Migration
  def change
    add_column :basics, :buildingType, :string
    add_column :basics, :buildingId, :integer
  end
end
