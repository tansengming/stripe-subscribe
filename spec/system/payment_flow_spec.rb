require 'rails_helper'

RSpec.describe 'Payment Flow' do
  let(:user) { User.create! email: "#{SecureRandom.uuid}@example.com", password: SecureRandom.uuid }
  before { sign_in user }

  it do
    visit '/stripe/subscribe/plans'
    expect(page.current_path).to eq '/stripe/subscribe/plans'

    # pick a plan
    within '#pro-plan' do
      click_on 'Get Started'
    end

    expect(page.current_path).to eq '/stripe/subscribe/payment/new'
    # Note: cannot fulfill payment because there is no way to
    # get a Strip token. Goes to failure path instead.
    click_on 'Submit Payment'
    expect(page.current_path).to eq '/stripe/subscribe/plans'
  end
end
