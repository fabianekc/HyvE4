require 'spec_helper'

describe "Project pages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "show" do
    let(:project) { FactoryGirl.create(:project, user: user) }
    before do
      visit project_path(project)
    end

    it { should have_selector('h1', text: project.name) }
    it { should have_selector('title', text: project.name) }

    describe "category" do
      before do
        visit category_project_path(project, :page => 1)
      end

      it { should have_selector('h1', text: project.name) }
      it { should have_selector('title', text: project.name) }
    end
  end

  describe "index" do
    before do
      FactoryGirl.create(:project, user: user, name: "Project1")
      FactoryGirl.create(:project, user: user, name: "Project2")
      visit projects_path
    end

    it { should have_selector('title', text: 'All Projects') }
    it { should have_selector('h1',    text: 'All Projects') }

    describe "pagination" do
      before(:all) { 50.times { FactoryGirl.create(:project, user: user) } }
      after(:all)  { Project.delete_all }

      it { should have_selector('div.pagination') }

      it "should list each project" do
        Project.paginate(page: 1).each do |project|
          page.should have_selector('li', text: project.name)
        end
      end
    end
  end

  describe "creation" do
    before { visit root_path }

    describe "with invlid information" do
      it "should not create a project" do
        expect { click_button "create_project" }.not_to change(Project, :count)
      end

      describe "error messages" do
        before { click_button "create_project" }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do
      before { fill_in 'project_name', with: "My Valid Project" }
      it "should create a project" do
        expect { click_button "create_project" }.to change(Project, :count).by(1)
      end
    end
  end

  describe "edit" do
    let(:project) { FactoryGirl.create(:project, user: user) }
    before { visit edit_project_path(project) }

    describe "page" do
      it { should have_selector('h1',    text: "Update Project") }
      it { should have_selector('title', text: "Edit Project") }
    end

    describe "with invalid information" do
      before do
        fill_in 'project_name', with: " "
        click_button "Update"
      end

      it { should have_content('error') }
    end

    describe "with valid information" do
      let(:new_name) { "New Project" }
      before do
        fill_in "Project name", with: new_name
        click_button "Update"
      end

      it { should have_selector('title', text: new_name) }
      it { should have_selector('div.alert.alert-success') }
      specify { project.reload.name.should == new_name }
    end
  end

  describe "delete" do
    let(:project) { FactoryGirl.create(:project, user: user) }
    before do
      visit edit_project_path(project)
      save_page
    end
    it { should have_button('delete_project') }
    it "should be able to delete project" do
      expect { click_button 'delete_project' }.to change(Project, :count).by(-1)
    end
  end
end
