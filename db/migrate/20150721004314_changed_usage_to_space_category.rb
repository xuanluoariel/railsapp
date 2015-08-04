class ChangedUsageToSpaceCategory < ActiveRecord::Migration
  def change
    remove_column :space_categories, :usage, :integer
    add_column :space_categories, :usage, :string
  end
end
