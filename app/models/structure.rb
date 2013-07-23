# == Schema Information
#
# Table name: structures
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  group_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  comment    :text
#

class Structure < ActiveRecord::Base
  attr_accessible :name, :comment
  belongs_to :group
  has_many   :datavals, dependent: :destroy
  validates :group_id, presence: true
  validates :name,     presence: true, length: { maximum: 100 }
end
