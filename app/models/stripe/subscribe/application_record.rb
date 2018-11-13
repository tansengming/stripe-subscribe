# frozen_string_literal: true

module Stripe
  module Subscribe
    class ApplicationRecord < ActiveRecord::Base
      self.abstract_class = true
    end
  end
end
