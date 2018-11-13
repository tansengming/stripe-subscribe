# frozen_string_literal: true

module Stripe
  module Subscribe
    class PaymentForm
      include ActiveModel::Model

      attr_accessor :stripeToken, :plan

      validates :stripeToken, presence: true
      validates :plan, presence: true
      validates :plan, inclusion: { in: Stripe::Plans.all.map(&:id).map(&:to_s) }
    end
  end
end
