require 'spec_helper'

describe "PostingPages" do
  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "posting creation" do
    before { visit root_path }

    describe "with invalid information" do

      it "should not create a posting" do
        expect { click_button "Post" }.not_to change(Posting, :count)
      end

      describe "error messages" do
        before { click_button "Post" }
        it { should have_content('error') } 
      end
    end

    describe "with valid information" do

      before { fill_in 'posting_content', with: "Lorem ipsum" }
      it "should create a posting" do
        expect { click_button "Post" }.to change(Posting, :count).by(1)
      end
    end
  end

  describe "posting destruction" do
    before { FactoryGirl.create(:posting, user: user) }

    describe "as correct user" do
      before { visit root_path }

      it "should delete a posting" do
        expect { click_link "delete" }.to change(Posting, :count).by(-1)
      end
    end
  end

end
