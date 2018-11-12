# This file contains descriptions of all your stripe plans

# Example
# Stripe::Plans::PRIMO #=> 'primo'

Stripe.plan :pro do |plan|
  plan.name = 'Professional'
  plan.amount = 1999
  plan.interval = 'month'
end

Stripe.plan :enterprise do |plan|
  plan.name = 'Enterprise'
  plan.amount = 9999
  plan.interval = 'month'
end

# Once you have your plans defined, you can run
#
#   rake stripe:prepare
#
# This will export any new plans to stripe.com so that you can
# begin using them in your API calls.
