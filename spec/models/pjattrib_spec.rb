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

require 'spec_helper'

describe Pjattrib do
  let(:user) { FactoryGirl.create(:user) }
  let(:project) { FactoryGirl.create(:project, user: user) }
  before do
    @pjattrib = project.pjattribs.build(attrtype: 1, attrvalue: "0")
  end

  subject { @pjattrib }

  it { should respond_to(:attrtype) }
  it { should respond_to(:attrvalue) }

  it { should be_valid }

  describe "accessible attributes" do
    it "should not allow access to project_id" do
      expect do
        Pjattrib.new(project_id: project.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

  describe "when project_id is not prosent" do
    before { @pjattrib.project_id = nil }
    it { should_not be_valid }
  end
end
