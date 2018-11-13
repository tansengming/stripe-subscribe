# frozen_string_literal: true

module Stripe
  module Subscribe
    class RemoteResource < ApplicationRecord
      scope :customers, -> { where(remote_resource_type: 'customer') }

      def retrieve
        "Stripe::#{remote_resource_type.capitalize}".constantize.retrieve(remote_resource_id)
      end
    end
  end
end
