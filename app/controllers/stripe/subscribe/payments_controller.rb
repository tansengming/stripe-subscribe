module Stripe
  module Subscribe
    class PaymentsController < ApplicationController
      layout 'stripe/subscribe/application'

      rescue_from Stripe::InvalidRequestError, with: :retry_payment
      helper_method :selected_plan

      def new
        if selected_plan
          render
        else
          redirect_to stripe_subscribe.plans_path, flash: { alert: 'Please select a plan before continuing.' }
        end
      end

      def create
        @form = PaymentForm.new(payment_params)

        if @form.valid?
          Payments::Create.(stripe_token: payment_params[:stripeToken], plan_name: payment_params[:plan], user: current_user)

          redirect_to after_payment_success_path(current_user)
        else
          retry_payment
        end
      end

      private

      def payment_params
        params.permit(:stripeToken, :plan)
      end

      def after_payment_success_path(resource)
        signed_in_root_path(resource)
      end

      def retry_payment
        redirect_to(stripe_subscribe.new_payment_path, flash: { alert: 'There was a problem with the payment, please try again' }) && return
      end

      def selected_plan
        Stripe::Plans.all.find { |plan| plan.id.to_s == params[:plan] }
      end
    end
  end
end
