require "spec_helper"

describe UserMailer do
  describe "password_reset" do
    let(:user) { FactoryGirl.create(:user, password_reset_token: "asdf") }
    let(:mail) { UserMailer.password_reset(user) }

    it "renders the headers" do
      mail.subject.should eq("[Hyve.me]: Password Reset")
      mail.to.should eq([user.email])
      mail.from.should eq(["info@hyve.me"])
    end

    it "renders the body" do
      mail.body.encoded.should match("To reset your password click the URL")
    end
  end

end
