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
#  emaildata   :boolean
#

require 'spec_helper'

describe Project do

  let(:user) { FactoryGirl.create(:user) }
  before do
    @project = user.projects.build(name: "My Project")
  end

  subject { @project }

  it { should respond_to(:user_id) }
  it { should respond_to(:name) }
  it { should respond_to(:description) }
  it { should respond_to(:wissen) }
  it { should respond_to(:tun) }
  it { should respond_to(:hoffen) }

  it { should be_valid }

  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Project.new(user_id: user.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end    
  end

  describe "when user_id is not present" do
    before { @project.user_id = nil }
    it { should_not be_valid }
  end

  describe "with blank project name" do
    before { @project.name = " " }
    it { should_not be_valid }
  end

  describe "with project name that is too long" do
    before { @project.name = "a"*51 }
    it { should_not be_valid }
  end

  describe "with project description is too long" do
    before { @project.description = "a"*2001 }
    it { should_not be_valid }
  end

  describe "with valid project description" do
    before { @project.description = "a"*2000 }
    it { should be_valid }
  end
end
