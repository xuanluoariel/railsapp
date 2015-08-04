class AddSpaceNumToSpaces < ActiveRecord::Migration
  def change
    add_column :basics, :isModified, :integer
    add_column :spaces, :occupant_num, :integer
  end
end
