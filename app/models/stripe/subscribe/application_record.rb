module Stripe
  module Subscribe
    class ApplicationRecord < ActiveRecord::Base
      self.abstract_class = true
    end
  end
end
