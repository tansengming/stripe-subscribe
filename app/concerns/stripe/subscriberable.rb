# frozen_string_literal: true

module Stripe
  module Subscriberable
    extend ActiveSupport::Concern

    included do
      has_many :stripe_remote_resources, as: :stripeable, class_name: 'Stripe::Subscribe::RemoteResource'
      # has_one   :stripe_customer, -> { stripe_customers.order('id desc') }, class_name: 'RemoteKey', as: :remoteable
    end

    def stripe_customer=(stripe_customer)
      stripe_remote_resources.customers.create! remote_resource_id: stripe_customer.id
    end

    def stripe_customer
      @stripe_customer ||= stripe_customer_remote_resource.retrieve if stripe_customer_id?
    end

    def stripe_subscriptions
      if stripe_customer?
        stripe_customer.subscriptions
      else
        []
      end
    end

    def stripe_active_subscriptions
      stripe_subscriptions.select { |subscription| subscription.status == 'active' }
    end

    def stripe_active_subscription?
      stripe_active_subscriptions.any?
    end

    private

    def stripe_customer_remote_resource
      stripe_remote_resources.customers.order('id desc').first
    end

    def stripe_customer_id?
      stripe_customer_remote_resource.present?
    end

    def stripe_customer?
      stripe_customer.present?
    end
  end
end
