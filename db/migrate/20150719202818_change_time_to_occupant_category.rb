class ChangeTimeToOccupantCategory < ActiveRecord::Migration
  def change
    remove_column :occupant_categories, :ATypical, :time
    add_column :occupant_categories, :ATypical, :string
    
    remove_column :occupant_categories, :AStart, :time
    add_column :occupant_categories, :AStart, :string
    
    remove_column :occupant_categories, :AEnd, :time
    add_column :occupant_categories, :AEnd, :string
    
    remove_column :occupant_categories, :GTLTypical, :time
    add_column :occupant_categories, :GTLTypical, :string
    
    remove_column :occupant_categories, :GTLStart, :time
    add_column :occupant_categories, :GTLStart, :string
    
    remove_column :occupant_categories, :GTLEnd, :time
    add_column :occupant_categories, :GTLEnd, :string
    
    remove_column :occupant_categories, :BFLTypical, :time
    add_column :occupant_categories, :BFLTypical, :string
    
    remove_column :occupant_categories, :BFLStart, :time
    add_column :occupant_categories, :BFLStart, :string
    
    remove_column :occupant_categories, :BFLEnd, :time
    add_column :occupant_categories, :BFLEnd, :string
    
    remove_column :occupant_categories, :DTypical, :time
    add_column :occupant_categories, :DTypical, :string
    
    remove_column :occupant_categories, :DStart, :time
    add_column :occupant_categories, :DStart, :string
    
    remove_column :occupant_categories, :DEnd, :time
    add_column :occupant_categories, :DEnd, :string
    
    remove_column :meetings, :start_time, :time
    add_column :meetings, :start_time, :string
    
    remove_column :meetings, :end_time, :time
    add_column :meetings, :end_time, :string
  end
end
