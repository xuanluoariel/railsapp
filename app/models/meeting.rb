class Meeting < ActiveRecord::Base
  belongs_to :space_category
  validates :duration, numericality: { greater_than: 0 }
  validates :prob, numericality: { greater_than: 0, less_than_or_equal_to: 100}
end
