class AddIsOfficeToSpaceCategory < ActiveRecord::Migration
  def change
    add_column :space_categories, :is_office, :integer
  end
end
