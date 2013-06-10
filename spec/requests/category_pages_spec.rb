require 'spec_helper'

describe "Project categories" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  let(:project) { FactoryGirl.create(:project, user: user) }
  before do
    sign_in user
    visit project_path(project)
  end

  describe "not set" do
    describe "without opening Category panel" do
      it { should_not have_link "set Categories" }
    end

    describe "with opening Category panel" do
      before do
        click_link "Category"
      end
      it { should have_link "set Categories" }
    end

  end

end
