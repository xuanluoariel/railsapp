class CreateMeetings < ActiveRecord::Migration
  def change
    create_table :meetings do |t|
      t.time :duration
      t.time :start_time
      t.time :end_time
      t.decimal :prob

      t.timestamps null: false
    end
  end
end
