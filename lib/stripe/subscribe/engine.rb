# frozen_string_literal: true

module Stripe
  module Subscribe
    class Engine < ::Rails::Engine
      isolate_namespace Stripe::Subscribe
    end
  end
end
