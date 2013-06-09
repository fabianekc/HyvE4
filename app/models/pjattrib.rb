# == Schema Information
#
# Table name: pjattribs
#
#  id         :integer          not null, primary key
#  project_id :integer
#  attrtype   :integer
#  attrvalue  :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Pjattrib < ActiveRecord::Base
  attr_accessible :attrtype, :attrvalue
  belongs_to :project
  validates :project_id, presence: true
end
