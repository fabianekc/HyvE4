# == Schema Information
#
# Table name: groups
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  project_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  comment    :text
#

class Group < ActiveRecord::Base
  attr_accessible :name, :comment
  belongs_to :project
  has_many   :structures
  validates :project_id, presence: true
  validates :name,       presence: true, length: { maximum: 100 }
end
