class AddErrToSpaceCategories < ActiveRecord::Migration
  def change
    add_column :space_categories, :err, :text
  end
end
