require 'spec_helper'

describe Invite do
  before { @invite = Invite.new(name: "Example User", email: "user@exmaple.org", bio: "Its me.", reason: "just because", rtype: "Submit") }

  subject { @invite }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:bio) }
  it { should respond_to(:reason) }
  it { should respond_to(:rtype) }
end
