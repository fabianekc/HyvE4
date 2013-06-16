class Structure < ActiveRecord::Base
  attr_accessible :name
  belongs_to :group
  has_many   :datavals
  validates :group_id, presence: true
  validates :name,     presence: true, length: { maximum: 50 }
end
