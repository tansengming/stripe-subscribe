# Stripe::Subscribe: Stripe subscriptions made easy

[![Gem Version](https://badge.fury.io/rb/stripe-subscribe.png)](http://badge.fury.io/rb/stripe-subscribe)
[![Build Status](https://travis-ci.org/tansengming/stripe-subscribe.png?branch=master)](https://travis-ci.org/tansengming/stripe-subscribe)
[![Code Climate](https://codeclimate.com/github/tansengming/stripe-subscribe/badges/gpa.svg)](https://codeclimate.com/github/tansengming/stripe-subscribe)
[![Test Coverage](https://codeclimate.com/github/tansengming/stripe-subscribe/badges/coverage.svg)](https://codeclimate.com/github/tansengming/stripe-subscribe/coverage)

🔴 **This gem is still in Alpha and has not been tested on Production** 🔴

This is a Rails Engine that makes it easy to work with Stripe Subscriptions. It gives you 2 major things,

- views and controllers so a user can select a plan and pay for it
- methods on the model to fetch it's Stripe customer and subscriptions

Checking a user's subscription and getting the user to subscribe to a plan can be as simple as,

```ruby
# app/controllers/paid_features_controller.rb
class PaidFeaturesController < ApplicationController
  def show
    if current_user.active_stripe_subcsriptions? # fetches subscription details from Stripe
      render
    else
      redirect_to stripe_subscribe.plans_path # to select and pay for a plan
    end
  end
end
```

[📫 Sign up for the Newsletter](http://tinyletter.com/stripe-rails) to receive occasional updates.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'stripe-subscribe'
```

And then execute:
```bash
$ bundle
```

Install and run the migrations:

```bash
$ rails stripe_subscribe:install:migrations
$ rails db:migrate
```

## Getting Started

These are the files that have to be updated on your Rails app. Don't panic.

```
.
├─ config
│  ├─ stripe
│  │  └─ plans.rb
│  └─ routes.rb
└─ app
   ├─ models
   │  └─ user.rb
   └─ controllers
      └─ paid_features_controller.rb
```

Configure your plans at `config/stripe/plans.rb`. The plans defined here will be uploaded to Stripe and used to render the plans page,

```ruby
# config/stripe/plans.rb
Stripe.plan :pro do |plan|
  plan.name = 'Professional'
  plan.amount = 1999
  plan.currency = 'usd'
  plan.interval = 'month'
end
```

Run this to upload the plans to Stripe,

```bash
$ rake stripe:prepare
```

Update the routes to mount the engine. This will be the routes where users get to select a plan and pay for it. Make sure it is mounted within Devise's `authenticate` helper so only authenticated users get access.

```ruby
# config/routes.rb
Rails.application.routes.draw do
  authenticate :user do
    mount Stripe::Subscribe::Engine => "/stripe/subscribe"
  end
end
```

Include the module to mix in Stripe subscription methods to the `User`. E.g. `#active_stripe_subcsriptions?`, `stripe_customer` etc.

```ruby
# app/models/user.rb
class User < ApplicationRecord
  include Stripe::Subscriberable
end
```

You are now ready for user subscriptions on Stripe!

You could use the new methods to retrieve a user's subscription status on the controller and block access to the action until they become a subscriber. Redirecting users to `stripe_subscribe.plans_path` will take the user to a page with the plans listed on `config/stripe/plans.rb`. They will then be able to select a plan and pay for them on those pages.

```ruby
# app/controllers/paid_features_controller.rb
class PaidFeaturesController < ApplicationController
  def show
    if current_user.active_stripe_subcsriptions?
      render
    else
      redirect_to stripe_subscribe.plans_path
    end
  end
end
```

## Customizing

TBD

## Contributing

Contribution directions go here.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
