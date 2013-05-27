require 'spec_helper'

describe "Password reset page" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }

  before do
    visit '/password_resets/new'
  end

  it { should have_selector('title', text: 'Reset Password') }
  it { should have_selector('h1',    text: 'Reset Password') }

end
