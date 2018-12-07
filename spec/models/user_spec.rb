require 'spec_helper'

describe User do
  subject { create(:user) }

  it 'sends an email' do
    expect { subject.send_activation_email }
      .to change { ActionMailer::Base.deliveries.count }.by(1)
  end
end
