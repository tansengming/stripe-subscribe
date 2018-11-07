module Stripe
  module Subscribe
    class PlansController < ApplicationController
      layout 'stripe/subscribe/application'

      def index
        @plans = Stripe::Plans.all
      end
    end
  end
end
