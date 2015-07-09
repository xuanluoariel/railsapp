class CreateOccupants < ActiveRecord::Migration
  def change
    create_table :occupants do |t|
      t.string :occupantType
      t.integer :percentage
      t.references :SpaceCategory, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
