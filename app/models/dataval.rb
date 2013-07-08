# == Schema Information
#
# Table name: datavals
#
#  id           :integer          not null, primary key
#  value        :string(255)
#  structure_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  valdatime    :datetime
#  comment      :text
#

class Dataval < ActiveRecord::Base
  attr_accessible :valdatime, :value, :comment
  belongs_to :structure
  validates :structure_id, presence: true
end
