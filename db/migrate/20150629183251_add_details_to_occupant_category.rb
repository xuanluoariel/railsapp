class AddDetailsToOccupantCategory < ActiveRecord::Migration
  def change
    add_column :occupant_categories, :auxPercent, :integer
    add_column :occupant_categories, :auxDuration, :time
  end
end
