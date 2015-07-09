class CreateSpaces < ActiveRecord::Migration
  def change
    create_table :spaces do |t|
      t.string :name
      t.string :spaceType
      t.integer :multiplier
      t.decimal :area

      t.timestamps null: false
    end
  end
end
