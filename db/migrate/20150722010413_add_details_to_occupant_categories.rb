class AddDetailsToOccupantCategories < ActiveRecord::Migration
  def change
    remove_column :occupant_categories, :ATypical, :string
    remove_column :occupant_categories, :AStart, :string
    remove_column :occupant_categories, :AEnd, :string
    remove_column :occupant_categories, :GTLTypical, :string
    remove_column :occupant_categories, :GTLStart, :string
    remove_column :occupant_categories, :GTLEnd, :string
    remove_column :occupant_categories, :BFLTypical, :string
    remove_column :occupant_categories, :BFLStart, :string
    remove_column :occupant_categories, :BFLEnd, :string
    remove_column :occupant_categories, :DTypical, :string
    remove_column :occupant_categories, :DStart, :string
    remove_column :occupant_categories, :DEnd, :string
    remove_column :occupant_categories, :ownPercent, :integer
    remove_column :occupant_categories, :ownDuration, :integer
    remove_column :occupant_categories, :otherPercent, :integer
    remove_column :occupant_categories, :otherDuration, :integer
    remove_column :occupant_categories, :meetingPercent, :integer
    remove_column :occupant_categories, :meetingDuration, :integer
    remove_column :occupant_categories, :auxPercent, :integer
    remove_column :occupant_categories, :auxDuration, :integer
    remove_column :occupant_categories, :outPercent, :integer
    remove_column :occupant_categories, :outDuration, :integer
    add_column :occupant_categories, :event_type, :string
  end
end
