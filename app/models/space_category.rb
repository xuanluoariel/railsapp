class SpaceCategory < ActiveRecord::Base
  belongs_to :basic
  has_many :occupants
  has_many :meetings
  validates :name, presence: true
  def to_s
    name
  end
end
