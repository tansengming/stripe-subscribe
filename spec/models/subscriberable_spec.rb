# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Stripe::Subscriberable do
  before { StripeMock.start }
  after  { StripeMock.stop }

  let(:resource)        { User.create! email: "#{SecureRandom.uuid}@example.com", password: SecureRandom.uuid }
  let(:stripe_helper)   { StripeMock.create_test_helper }
  let(:stripe_customer) { Stripe::Customer.create source: stripe_helper.generate_card_token }

  describe 'stripe_active_subscription?' do
    subject { resource.stripe_active_subscription? }

    context 'when there is a stripe customer' do
      before { resource.stripe_remote_resources.customers.create! remote_resource_id: stripe_customer.id }

      context 'who does not have subscriptions' do
        it { should be_falsey }
      end

      context 'who has subscriptions' do
        let(:stripe_plan)     { stripe_helper.create_plan }
        let(:stripe_customer) { Stripe::Customer.create source: stripe_helper.generate_card_token, plan: stripe_plan.id }
        it { should be_truthy }
      end
    end

    context 'when there is not a stripe customer' do
      it { should be_falsey }
    end
  end
end
