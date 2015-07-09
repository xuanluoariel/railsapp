class SpaceCategory < ActiveRecord::Base
  belongs_to :basic
  has_many :occupants
  validates :name, presence: true
  validates :name, uniqueness: true
  validates :density, numericality: { greater_than_or_equal_to: 0 }
  def to_s
    name
  end
end
