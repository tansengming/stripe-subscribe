# This file contains descriptions of all your stripe plans

# Example
# Stripe::Plans::PRIMO #=> 'primo'

Stripe.plan :nice_tip do |plan|
  plan.name = 'Nice Tip'
  plan.amount = 699
  plan.interval = 'month'
end

# Once you have your plans defined, you can run
#
#   rake stripe:prepare
#
# This will export any new plans to stripe.com so that you can
# begin using them in your API calls.
