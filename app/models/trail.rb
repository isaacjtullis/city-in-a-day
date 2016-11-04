class Trail < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy

  PRICES = ['FREE', '10','15','20','30','100']
  MOOD = ['Adventure', 'Romance', 'Chill']

  validates :description,
    presence: true,
    length: { maximum: 140 }
  validates_presence_of :location
  validates_presence_of :name
  validates_presence_of :user
  validates :price, inclusion: { in: PRICES, message: "Not a valid price" }
  validates :mood, inclusion: { in: MOOD, message: "Not a valid mood"}

  def self.search(search)
    if search
      where("name ILIKE ?", "%#{search}")
    end
  end
end
