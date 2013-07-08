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

require 'spec_helper'

describe Dataval do
  let(:user)      { FactoryGirl.create(:user) }
  let(:project)   { FactoryGirl.create(:project, user: user) }
  let(:group)     { FactoryGirl.create(:group, project: project) }
  let(:structure) { FactoryGirl.create(:structure, group: group) }
  before do
    @dataval = structure.datavals.build(value: "lila")
  end

  subject { @dataval }

  it { should respond_to(:value) }
  it { should respond_to(:structure_id) }
  it { should be_valid }

  describe "when structure_id is not present" do
    before { @dataval.structure_id = nil }
    it { should_not be_valid }
  end

  describe "accessible attributes" do
    it "should not allow access to structure_id" do
      expect do
        Dataval.new(structure_id: structure.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end
end

