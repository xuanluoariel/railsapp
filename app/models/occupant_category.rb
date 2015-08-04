class OccupantCategory < ActiveRecord::Base
  belongs_to :basic
  has_many :movement_behaviors, dependent: :destroy
  validates :name, presence: true
  def to_s
    name
  end
end
