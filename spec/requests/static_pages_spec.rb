require 'spec_helper'

describe "Static pages" do

  describe "Home page" do
    it "should have the content 'We compare projects'" do
      visit root_path
      page.should have_content('Mission')
    end

    describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:posting, user: user, content: "Lorem ipsum")
        FactoryGirl.create(:posting, user: user, content: "Dolor sit amet")
        sign_in user
        visit root_path
      end

      it "should render the user's feed" do
        user.feed.each do |item|
          page.should have_selector("li##{item.id}", text: item.content)
        end
      end

    end

  end

  describe "Imprint page" do
    it "should have the content 'Disclaimer'" do
      visit imprint_path
      page.should have_content('Disclaimer')
    end
  end

  describe "Mission page" do
    it "should have the content 'Mission'" do
      visit mission_path
      page.should have_content('Mission')
    end
  end

end
