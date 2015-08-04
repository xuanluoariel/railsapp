class AddSpaceNumberToBasics < ActiveRecord::Migration
  def change
    add_column :basics, :space_num, :integer
  end
end
