class AddBasicRefToSpaces < ActiveRecord::Migration
  def change
    # add_column :spaces, :basic, :reference
    add_reference :spaces, :basic, index: true, foreign_key: true
  end
end
