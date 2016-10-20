class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :trails, dependent: :destroy

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :bio,
    length: { maximum: 140 }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  def full_name(user)
    "#{user.first_name} #{user.last_name}"
  end
end
