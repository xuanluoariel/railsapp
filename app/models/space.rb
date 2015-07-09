class Space < ActiveRecord::Base
  belongs_to :basic
  validates :name,
            presence: true
  validates :name, uniqueness: true
  validates :multiplier, numericality: { greater_than_or_equal_to: 0 }
  validates :area, numericality: { greater_than_or_equal_to: 0 }
  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      Space.create! row.to_hash
    end
  end
end
 