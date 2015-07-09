class OccupantCategory < ActiveRecord::Base
  belongs_to :basic
  validates :name,
            presence: true
  def to_s
    name
  end
end
