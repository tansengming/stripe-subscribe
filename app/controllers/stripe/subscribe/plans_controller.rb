module Stripe
  module Subscribe
    class PlansController < ApplicationController
      # before_action :authenticate_user!

      def index
        @plans = Stripe::Plans.all
      end
    end
  end
end
