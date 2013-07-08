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

require 'spec_helper'

describe Structure do
  let(:user)    { FactoryGirl.create(:user) }
  let(:project) { FactoryGirl.create(:project, user: user) }
  let(:group)   { FactoryGirl.create(:group, project: project) }
  before do
    @structure = group.structures.build(name: "Barbabella")
  end

  subject { @structure }

  it { should respond_to(:name) }
  it { should respond_to(:group_id) }
  it { should be_valid }

  describe "when group_id is not present" do
    before { @structure.group_id = nil }
    it { should_not be_valid }
  end

  describe "accessible attributes" do
    it "should not allow access to group_id" do
      expect do
        Structure.new(group_id: group.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end
end

