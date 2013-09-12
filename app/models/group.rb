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
  attr_accessible :name, :comment, :lastmailsent
  belongs_to :project
  has_many   :structures, dependent: :destroy
  validates :project_id, presence: true
  validates :name,       presence: true, length: { maximum: 100 }

  def mail_datacollect
    GroupMailer.request_first_list(self).deliver
  end

end
