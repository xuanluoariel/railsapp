class CreateOccupantCategories < ActiveRecord::Migration
  def change
    create_table :occupant_categories do |t|
      t.string :name
      t.time :ATypical
      t.time :AStart
      t.time :AEnd
      t.time :WMTypical
      t.time :WMStart
      t.time :WMEnd
      t.time :GTLTypical
      t.time :GTLStart
      t.time :GTLEnd
      t.time :BFLTypical
      t.time :BFLStart
      t.time :BFLEnd
      t.time :WATypical
      t.time :WAStart
      t.time :WAEnd
      t.time :DTypical
      t.time :DStart
      t.time :DEnd
      t.integer :ownPercent
      t.time :ownDuration
      t.integer :otherPercent
      t.time :otherDuration
      t.integer :meetingPercent
      t.time :meetingDuration
      t.integer :otherPercent
      t.time :otherDuration
      t.integer :outPercent
      t.time :outDuration
      t.references :basic, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
