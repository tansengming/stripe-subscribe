module Stripe
  module Subscribe
    module Payments
      class Create
        attr_reader :stripe_token, :user, :plan_name

        def self.call(stripe_token:, plan_name:, user:)
          new(stripe_token: stripe_token, plan_name: plan_name, user: user).call
        end

        def initialize(stripe_token:, plan_name:, user:)
          @stripe_token = stripe_token
          @plan_name    = plan_name
          @user         = user
        end

        def call
          new_stripe_customer = Stripe::Customer.create(
            email: user.email,
            source: stripe_token,
            plan: plan_name
          )
          user.stripe_customer = new_stripe_customer
        end
      end
    end
  end
end
