class ChangedIsOfficeToSpaceCategory < ActiveRecord::Migration
  def change
    remove_column :space_categories, :is_office, :integer
    remove_column :space_categories, :is_meeting, :integer
    add_column :space_categories, :usage, :integer
  end
end
