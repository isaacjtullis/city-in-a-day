class Trail < ActiveRecord::Base
  mount_uploader :trail_photo, TrailPhotoUploader

  belongs_to :user
  has_many :locations, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :active_favorites, class_name: "Favorite",
                       foreign_key: "trail_id",
                       dependent: :destroy

  has_many :favorites, through: :active_favorites, source: :user

  MOOD = ['Adventure', 'Romance', 'Chill'] # TODO: make enum

  validates :mood, inclusion: { in: MOOD, message: "Not a valid mood"}
  validates_presence_of :name
  validates_presence_of :user

  def self.search(search)
    if search
      where("name ILIKE ?", "%#{search}")
    end
  end
end
