class Trail < ActiveRecord::Base
  mount_uploader :trail_photo, TrailPhotoUploader

  belongs_to :user
  has_many :locations, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :active_favorites, class_name: "Favorite",
                       foreign_key: "trail_id",
                       dependent: :destroy

  has_many :favorites, through: :active_favorites, source: :user
  CITY = ['Alabama', 'Alabama', 'Alaska', 'Arizona', 'Arkansas', 'California', 'Colorado', 'Connecticut', 'Delaware', 'Florida', 'Georgia', 'Hawaii', 'Idaho', 'Illinois', 'Indiana', 'Iowa', 'Kansas', 'Kentucky', 'Louisiana',
    'Maine', 'Maryland', 'Massachusetts', 'Michigan', 'Minnesota', 'Mississippi', 'Missouri', 'Montana', 'Nebraska', 'Nevada', 'New Hampshire', 'New Jersey', 'New Mexico',
    'New York', 'North Carolina', 'North Dakota', 'Ohio', 'Oklahoma', 'Oregon','Pennsylvania','Rhode Island', 'South Carolina', 'South Dakota', 'Tennessee',
    'Texas', 'Utah', 'Vermont', 'Virginia', 'Washington', 'West Virginia', 'Wisconsin', 'Wyoming']

  MOOD = ['Adventure', 'Romance', 'Chill']

  validates :mood, inclusion: { in: MOOD, message: "Not a valid mood"}
  validates_presence_of :name
  validates_presence_of :user
  
  def self.search(search)
    if search
      where("name ILIKE ?", "%#{search}")
    end
  end
end
