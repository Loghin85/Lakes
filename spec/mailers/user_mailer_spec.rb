require "spec_helper"

RSpec.describe UserMailer, :type => :mailer do
  describe 'activation' do
    let(:user) { create(:user) }
    let(:mail) { described_class.account_activation(user).deliver_now }

    it "renders the headers" do
      expect(mail.subject).to eq("Account activation")
      expect(mail.to).to eq([user.Email])
      expect(mail.from).to eq(["noreply@laketours.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end
  
  describe 'reset' do
    let(:user) { create(:user, reset_token: User.new_token)}
    let(:mail) { described_class.password_reset(user).deliver_now }

    it "renders the headers" do
      expect(mail.subject).to eq("Password reset")
      expect(mail.to).to eq([user.Email])
      expect(mail.from).to eq(["noreply@laketours.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("To reset your password")
    end
  end
end
