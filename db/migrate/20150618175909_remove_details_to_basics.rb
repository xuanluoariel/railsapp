class RemoveDetailsToBasics < ActiveRecord::Migration
  def change
    remove_column :basics, :type, :string
    remove_column :basics, :startTime, :datetime
    remove_column :basics, :endTime, :datetime
    remove_column :basics, :timeStep, :integer
  end
end
