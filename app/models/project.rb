# == Schema Information
#
# Table name: projects
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  name        :string(255)
#  description :text
#  wissen      :text
#  tun         :text
#  hoffen      :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category    :string(255)
#

class Project < ActiveRecord::Base
  attr_accessible :name, :description, :hoffen, :tun, :wissen, :emaildata

  belongs_to :user
  has_many :pjattribs, dependent: :destroy
  has_many :groups,    dependent: :destroy

  validates :user_id, presence: true
  validates :name,    presence:true, length: { maximum: 50 }
  validates :description,            length: { maximum: 2000 }
  validates :hoffen,                 length: { maximum: 2000 }
  validates :tun,                    length: { maximum: 2000 }
  validates :wissen,                 length: { maximum: 2000 }

  default_scope order: 'projects.name ASC'
end
