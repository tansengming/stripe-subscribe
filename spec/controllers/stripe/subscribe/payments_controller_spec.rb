# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Stripe::Subscribe::PaymentsController do
  let(:user) { User.create! email: "#{SecureRandom.uuid}@example.com", password: SecureRandom.uuid }
  before { sign_in user }
  routes { Stripe::Subscribe::Engine.routes }

  describe 'new' do
    subject { get :new }

    context 'when there is a selected plan' do
      subject { get :new, params: { plan: 'pro' } }
      it 'should be success' do
        expect(subject).to be_successful
      end
    end

    context 'when the selected plan is invalid' do
      subject { get :new, params: { plan: 'invalid' } }
      it 'should be a redirect' do
        expect(subject).to redirect_to '/stripe/subscribe/plans'
      end
    end

    context 'when there is not a selected plan' do
      it 'should be a redirect' do
        expect(subject).to redirect_to '/stripe/subscribe/plans'
      end
    end

    context 'when user is signed out' do
      before { sign_out user }

      it 'should be success' do
        expect(subject).to_not be_successful
      end
    end
  end

  describe 'create' do
    before  { StripeMock.start }
    after   { StripeMock.stop }
    subject { post :create, params: params }
    before  { stripe_helper.create_plan(id: 'pro') }
    let(:stripe_helper)  { StripeMock.create_test_helper }
    let(:default_params) { { stripeToken: stripe_helper.generate_card_token, plan: 'pro' } }

    context 'when there is a valid stripe token and plan' do
      let(:params) { default_params }

      it 'should create a new stripe customer' do
        expect { subject }.to change { Stripe::Subscribe::RemoteResource.count }.by(1)
        expect(subject).to redirect_to '/'
        expect(user.stripe_customer.subscriptions.data.map { |s| s.plan[:id] }).to eq ['pro']
      end
    end

    context 'when the plan is empty' do
      let(:params) { default_params.merge(plan: nil) }

      it 'should not create a new stripe customer' do
        expect { subject }.not_to change { Stripe::Subscribe::RemoteResource.count }
        expect(subject).to redirect_to '/stripe/subscribe/payment/new'
      end
    end

    context 'when the plan does not exist' do
      let(:params) { default_params.merge(plan: 'does_not_exist') }

      it 'should not create a new stripe customer' do
        expect { subject }.not_to change { Stripe::Subscribe::RemoteResource.count }
        expect(subject).to redirect_to '/stripe/subscribe/payment/new'
      end
    end

    context 'when the token is invalid' do
      let(:params) { default_params.merge(stripeToken: 'sk_test_fake') }

      it 'should not create a new stripe customer' do
        expect { subject }.not_to change { Stripe::Subscribe::RemoteResource.count }
        expect(user.reload.stripe_customer).to be_nil
        expect(subject).to redirect_to '/stripe/subscribe/payment/new'
      end
    end

    context 'when the token is empty' do
      let(:params) { default_params.merge(stripeToken: nil) }

      it 'should not create a new stripe customer' do
        expect { subject }.not_to change { Stripe::Subscribe::RemoteResource.count }
        expect(user.reload.stripe_customer).to be_nil
        expect(subject).to redirect_to '/stripe/subscribe/payment/new'
      end
    end
  end
end
