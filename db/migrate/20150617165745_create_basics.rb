class CreateBasics < ActiveRecord::Migration
  def change
    create_table :basics do |t|
      t.string :buildingType
      t.datetime :startTime
      t.datetime :endTime
      t.integer :timeStep

      t.timestamps null: false
    end
  end
end
