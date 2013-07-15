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
    before do
      click_link "Category"
    end
    it { should have_link "set Categories" }
  end

  describe "set categories" do
    before do
      click_link "Category"
      click_link "set_categories"
    end
    it { should have_selector('title', text: "Category (Team Size) | " +  project.name) }
    it { should have_selector('title', text: "Team Size") }
  end

  describe "list categories" do
    before do
      click_link "Category"
      click_link "set_categories"
      click_link "cancel_categories"
    end
    it { should_not have_selector('title', text: "Category") }
    it { should have_selector('title', text: project.name) }
    it { should have_content('Team Size') }
    it { should have_content('Duration') }
    it { should_not have_link('set Categories') }
  end

  describe "similar projects" do
    let(:project2) { FactoryGirl.create(:project, user: user, name: "Project2") }
    before do
      visit project_path(project)
      click_link "Category"
      click_link "set_categories"
      click_link "cancel_categories"
      visit project_path(project2)
      click_link "Category"
      click_link "set_categories"
      click_link "cancel_categories"
    end
    it { should have_selector('h3', text: "Similar Projects") }
  end

  describe "navigation" do
    before do
      click_link "Category"
      click_link "set_categories"
    end

    describe "next page" do
      before do
        click_button "Next"
      end
      it { should have_selector('title', text: "Category (Duration) | " +  project.name) }
    end

    describe "previous page" do
      before do
        3.times { click_button "Next" }
        click_button "Previous"
      end
      it { should have_selector('title', text: "Category (Process) | " +  project.name) }
    end
  end
end
