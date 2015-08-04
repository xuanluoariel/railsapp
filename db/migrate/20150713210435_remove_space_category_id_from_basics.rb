class RemoveSpaceCategoryIdFromBasics < ActiveRecord::Migration
  def change
    remove_column :basics, :spaceCategory_id, :integer
    add_column :basics, :total_area, :decimal
    add_column :space_categories, :energy_use, :string
    remove_column :occupant_categories, :WMTypical, :time
    remove_column :occupant_categories, :WMStart, :time
    remove_column :occupant_categories, :WMEnd, :time
    remove_column :occupant_categories, :WATypical, :time
    remove_column :occupant_categories, :WAStart, :time
    remove_column :occupant_categories, :WAEnd, :time
  end
end
