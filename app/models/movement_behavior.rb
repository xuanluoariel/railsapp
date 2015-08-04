class MovementBehavior < ActiveRecord::Base
  belongs_to :occupant_category
  def to_s
    event_type
  end
end
