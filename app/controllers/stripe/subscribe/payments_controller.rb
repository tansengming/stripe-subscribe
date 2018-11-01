module Stripe
  module Subscribe
    class PaymentsController < ApplicationController
      rescue_from Stripe::InvalidRequestError, with: :retry_payment
      # before_action :authenticate_user! # 'TODO'
      helper_method :selected_plan

      def new
        if selected_plan
          render
        else
          redirect_to stripe_subscribe.plans_path, flash: { alert: 'Please select a plan before continuing.' }
        end
      end

      def create
        payment_params = params.slice(:stripeToken, :plan)
        @form = PaymentForm.new(OpenStruct.new)

        if @form.validate(payment_params)
          Payments::Create.(stripe_token: payment_params[:stripeToken], plan_name: payment_params[:plan], user: current_user)

          redirect_to page_path('thanks')
        else
          retry_payment
        end
      end

      private

      def retry_payment
        redirect_to(stripe_subscribe.new_payment_path, flash: { alert: 'There was a problem with the payment, please try again' }) && return
      end

      def selected_plan
        Stripe::Plans.all.find { |plan| plan.id.to_s == params[:plan] }
      end
    end
  end
end
