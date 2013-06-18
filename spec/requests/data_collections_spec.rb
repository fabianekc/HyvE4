require 'spec_helper'

describe "DataCollections" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  let(:project) { FactoryGirl.create(:project, user: user) }
  before do
    sign_in user
    visit project_path(project)
  end

  describe "new group" do
    before { click_link "Tracking" }
    it { should have_link "New Group" }

    describe "create" do
      before { click_link "New Group" }
      it { should have_selector('h3', :text => 'New Group') }

      describe "with valid information" do
        before do
          fill_in 'Name', with: 'Group 0'
        end
        it "should create record" do
          expect { click_button "Create" }.to change(Group, :count).by(1)
        end
      end

      describe "and edit" do

        describe "and delete" do

        end
      end
    end
  end

  describe "new structure" do
    before do
      click_link "Tracking"
      click_link "New Group"
      fill_in 'Name', with: 'Group 0'
      click_button "Create"
    end
    it { should have_link "New Item" }

    describe "create" do
      before { click_link "New Item" }
      it { should have_selector('h3', :text => 'New Item') }

      describe "with valid information" do
        before do
          fill_in 'Name', with: 'Item 0'
          click_button "Create"
        end
        it { should have_selector('li', :text => 'Item 0') }
      end

      describe "and edit" do

        describe "and delete" do

        end
      end
    end
  end

end
