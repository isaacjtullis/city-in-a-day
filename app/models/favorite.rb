class Favorite < ActiveRecord::Base
  belongs_to :user, class_name: "User"
  belongs_to :trail, class_name: "Trail"

  validates :user_id, presence: true
  validates :trail_id, presence: true
end
