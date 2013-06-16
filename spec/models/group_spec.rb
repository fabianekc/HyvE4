require 'spec_helper'

describe Group do
  let(:user)    { FactoryGirl.create(:user) }
  let(:project) { FactoryGirl.create(:project, user: user) }
  before do
    @group = project.groups.build(name: "Barbapapa")
  end

  subject { @group }

  it { should respond_to(:name) }
  it { should respond_to(:project_id) }
  it { should be_valid }

  describe "when project_id is not present" do
    before { @group.project_id = nil }
    it { should_not be_valid }
  end

  describe "accessible attributes" do
    it "should not allow access to project_id" do
      expect do
        Group.new(project_id: project.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end
end
