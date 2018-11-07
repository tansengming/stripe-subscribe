module Stripe
  module Subscribe
    class PaymentForm < Reform::Form
      property :stripeToken
      property :plan

      validates :stripeToken, presence: true
      validates :plan, presence: true
      validates :plan, inclusion: { in: Stripe::Plans.all.map(&:id).map(&:to_s) }
    end
  end
end
