class Group < ActiveRecord::Base
  attr_accessible :name, :comment
  belongs_to :project
  has_many   :structures
  validates :project_id, presence: true
  validates :name,       presence: true, length: { maximum: 50 }
end
