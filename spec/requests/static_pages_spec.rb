require 'spec_helper'

describe "Static pages" do

  describe "Home page" do
    it "should have the content 'We compare projects'" do
      visit '/static_pages/home'
      page.should have_content('We compare projects')
    end
  end

  describe "Imprint page" do
    it "should have the content 'Disclaimer'" do
      visit '/static_pages/imprint'
      page.should have_content('Disclaimer')
    end
  end

  describe "Mission page" do
    it "should have the content 'Mission'" do
      visit '/static_pages/mission'
      page.should have_content('Mission')
    end
  end

end
