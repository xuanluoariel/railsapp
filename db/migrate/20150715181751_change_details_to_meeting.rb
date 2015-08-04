class ChangeDetailsToMeeting < ActiveRecord::Migration
  def change
    remove_column :meetings, :duration, :time
    add_column :meetings, :duration, :integer
    
    remove_column :occupant_categories, :ownDuration, :time
    add_column :occupant_categories, :ownDuration, :integer
    
    remove_column :occupant_categories, :otherDuration, :time
    add_column :occupant_categories, :otherDuration, :integer
    
    remove_column :occupant_categories, :meetingDuration, :time
    add_column :occupant_categories, :meetingDuration, :integer
    
    remove_column :occupant_categories, :auxDuration, :time
    add_column :occupant_categories, :auxDuration, :integer
    
    remove_column :occupant_categories, :outDuration, :time
    add_column :occupant_categories, :outDuration, :integer
  end
end
