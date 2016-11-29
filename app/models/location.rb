class Location < ActiveRecord::Base
  belongs_to :trail

  PRICES = ['FREE', '10','15','20','30','100']

  validates :description,
    presence: true,
    length: { maximum: 140 }

  validates_presence_of :location
  validates_presence_of :name
  validates_presence_of :trail
  validates :price, inclusion: { in: PRICES, message: "Not a valid price" }
end
