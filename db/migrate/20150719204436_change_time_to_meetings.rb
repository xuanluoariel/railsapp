class ChangeTimeToMeetings < ActiveRecord::Migration
  def change
    remove_column :meetings, :start_time, :time
    add_column :meetings, :start_time, :string
    
    remove_column :meetings, :end_time, :time
    add_column :meetings, :end_time, :string
  end
end
