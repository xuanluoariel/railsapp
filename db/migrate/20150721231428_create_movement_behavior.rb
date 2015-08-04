class CreateMovementBehavior < ActiveRecord::Migration
  def change
    create_table :movement_behaviors do |t|
      t.string :event_type
      t.string :ATypical
      t.string :AStart
      t.string :AEnd
      t.string :GTLTypical
      t.string :GTLStart
      t.string :GTLEnd
      t.string :BFLTypical
      t.string :BFLStart
      t.string :BFLEnd
      t.string :DTypical
      t.string :DStart
      t.string :DEnd
      t.integer :ownPercent
      t.integer :ownDuration
      t.integer :otherPercent
      t.integer :otherDuration
      t.integer :meetingPercent
      t.integer :meetingDuration
      t.integer :auxPercent
      t.integer :auxDuration
      t.integer :outPercent
      t.integer :outDuration
      t.references :occupant_category, index: true, foreign_key: true
      t.timestamps null: false
    end
    add_column :occupant_categories, :event_type, :string
  end
end
