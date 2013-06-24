require 'spec_helper'

describe "User pages" do

  subject { page }

  describe "create user", :js => true do
    before do
      visit root_path
      fill_in 'user_name', with: "User1"
      fill_in 'user_email', with: "user@hyve.me"
      fill_in "user_password", with: "password123"
      click_button "create_user"
      visit root_path
      find('#usertitle').trigger(:mouseover)
      click_link 'user_hover_edit'
    end
    it { should have_selector('title', text: 'Edit user') }
  end
end
