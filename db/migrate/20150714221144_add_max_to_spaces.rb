class AddMaxToSpaces < ActiveRecord::Migration
  def change
    add_column :space_categories, :max_num, :integer
    add_column :space_categories, :min_num, :integer
  end
end
