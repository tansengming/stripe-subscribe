# frozen_string_literal: true

module Stripe
  module Subscribe
    class ApplicationMailer < ActionMailer::Base
      default from: 'from@example.com'
      layout 'mailer'
    end
  end
end
