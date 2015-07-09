class Basic < ActiveRecord::Base
  has_many :spaces, dependent: :destroy
  has_many :space_categories, dependent: :destroy
  has_many :occupant_categories, dependent: :destroy
  validates :buildingType,
            presence: true
  def to_s
    buildingType
  end
end
