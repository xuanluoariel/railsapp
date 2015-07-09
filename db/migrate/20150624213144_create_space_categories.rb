class CreateSpaceCategories < ActiveRecord::Migration
  def change
    create_table :space_categories do |t|
      t.string :name
      t.decimal :density
      t.references :basic, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
