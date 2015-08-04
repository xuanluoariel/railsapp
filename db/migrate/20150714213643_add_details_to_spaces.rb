class AddDetailsToSpaces < ActiveRecord::Migration
  def change
    add_column :space_categories, :is_meeting, :integer
    add_reference :meetings, :space_category, index: true, foreign_key: true
  end
end
