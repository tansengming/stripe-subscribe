# Stripe::Subscribe
Short description and motivation.

## Usage
How to use my plugin.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'stripe-subscribe'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install stripe-subscribe
```

## Getting Started

```ruby
# config/stripe/plans.rb
Stripe.plan :primo do |plan|
  plan.name = 'Acme as a service PRIMO'
  plan.amount = 699
  plan.interval = 'month'
end

# `rake stripe:prepare` to upload the plan to Stripe
# `rails stripe_subscribe:install:migrations` to create db tables

# config/routes.rb
Rails.application.routes.draw do
  authenticate :user do
    mount Stripe::Subscribe::Engine => "/stripe/subscribe"
  end
end

# app/models/user.rb
class User < ApplicationRecord
  include Stripe::Subscriberable
end

# app/controllers/paid_features_controller.rb
class PaidFeaturesController < ApplicationController
  def show
    if current_user.active_stripe_subcsriptions?
      render
    else
      redirect_to stripe_subcribe_path
    end
  end
end
```

## Customizing

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
