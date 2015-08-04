class Space < ActiveRecord::Base
  belongs_to :basic
  validates :name, presence: true
  validates :multiplier, numericality: { greater_than: 0 }
  validates :area, numericality: { greater_than: 0 }
  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      Space.create! row.to_hash
    end
  end
end
 