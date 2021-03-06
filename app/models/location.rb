class Location < ActiveRecord::Base
  mount_uploader :photos, PhotosUploader
  belongs_to :trail

  validates :description,
    presence: true,
    length: { maximum: 140 }

  validates_presence_of :location
  validates_presence_of :name
  validates_presence_of :trail
  validates_presence_of :price
  validates_presence_of :order
end
