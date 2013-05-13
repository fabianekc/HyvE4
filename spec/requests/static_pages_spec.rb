require 'spec_helper'

describe "Static pages" do

  describe "Home page" do
    it "should have the content 'We compare projects'" do
      visit root_path
      page.should have_content('We compare projects')
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
