class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  mount_uploader :profile_photo, ProfilePhotoUploader

  has_many :trails, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :active_favorites, class_name: "Favorite",
                              foreign_key: "user_id",
                              dependent: :destroy
  has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy
  has_many :passive_relationships, class_name: "Relationship",
                                   foreign_key: "followed_id",
                                   dependent: :destroy

  has_many :favorites, through: :active_favorites, source: :trail

  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :username, presence: true
  validates :bio,
    length: { maximum: 140 }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def full_name(user)
    "#{user.first_name} #{user.last_name}"
  end

  def follow(other_user)
    active_relationships.create(followed_id: other_user)
  end

  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user).destroy
  end

  def following?(other_user)
   following.include?(other_user)
  end
end
