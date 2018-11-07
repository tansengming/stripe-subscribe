module Stripe
  module Subscribe
    class PlansController < ApplicationController
      def index
        @plans = Stripe::Plans.all
      end
    end
  end
end
