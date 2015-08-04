class AddSessionToBasics < ActiveRecord::Migration
  def change
    add_column :basics, :session_number, :integer
  end
end
