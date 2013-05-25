require 'spec_helper'

describe Posting do

  let(:user) { FactoryGirl.create(:user) }
  before { @posting = user.postings.build(content: "Lorem ipsum") }

  subject { @posting }

  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should == user }

  it { should be_valid }

  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Posting.new(user_id: user.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

  describe "when user_id is not present" do
    before { @posting.user_id = nil }
    it { should_not be_valid }
  end

  describe "with blank content" do
    before { @posting.content = " " }
    it { should_not be_valid }
  end

  describe "with content that is too long" do
    before { @posting.content = "a" * 2001 }
    it { should_not be_valid }
  end

end
