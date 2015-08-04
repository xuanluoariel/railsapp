class AddDetailToBasics < ActiveRecord::Migration
  def change
    add_column :basics, :start_year, :integer
    add_column :basics, :start_mon, :integer
    add_column :basics, :start_day, :integer
    add_column :basics, :end_year, :integer
    add_column :basics, :end_mon, :integer
    add_column :basics, :end_day, :integer
    add_column :basics, :time_step, :integer
  end
end
