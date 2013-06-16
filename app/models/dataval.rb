class Dataval < ActiveRecord::Base
  attr_accessible :valdatime, :value
  belongs_to :structure
  validates :structure_id, presence: true
end
