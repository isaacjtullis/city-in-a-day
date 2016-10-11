class Trail < ActiveRecord::Base
  validates_presence_of :description
  validates_presence_of :location
  validates_presence_of :name
end
