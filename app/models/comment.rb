class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :trail

  validates :description, length: { maximum: 140 },
     presence: true
  validates :user_id, presence: true
  validates :trail_id, presence: true
end
