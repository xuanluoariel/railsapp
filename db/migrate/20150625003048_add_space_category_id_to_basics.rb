class AddSpaceCategoryIdToBasics < ActiveRecord::Migration
  def change
    add_column :basics, :spaceCategory_id, :integer
  end
end
