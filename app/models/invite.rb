# == Schema Information
#
# Table name: invites
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  bio        :text
#  reason     :text
#  process    :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  rtype      :string(255)
#

class Invite < ActiveRecord::Base
  attr_accessible :bio, :email, :name, :process, :reason, :rtype
  validates :name, presence: true, length: { maximum: 100 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, length: { maximum: 100 }

end
