# Stripe::Subscribe: Stripe subscriptions made easy

*This is still in Alpha and not ready for Production*

This is a Rails Engine that makes it easy to work with Stripe Subscriptions. Checking a user's subscription status and getting them to pay for a plan is as simple as,

```ruby
# app/controllers/paid_features_controller.rb
class PaidFeaturesController < ApplicationController
  def show
    if current_user.active_stripe_subcsriptions? # fetches subscription details from Stripe
      render
    else
      redirect_to stripe_subscribe.plans_path # for users to select and pay for plans
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

## Getting Started

Start by installing and running migrations on the command line,

```bash
> rails stripe_subscribe:install:migrations
> rails db:migrate
```

Create plans files at `config/stripe/plans.rb`. This will be uploaded to Stripe and used to render the plans page.

```ruby
# config/stripe/plans.rb
Stripe.plan :pro do |plan|
  plan.name = 'Professional'
  plan.amount = 1999
  plan.currency = 'usd'
  plan.interval = 'month'
end
```

Run this on the command line to upload the plan to Stripe

```bash
> rake stripe:prepare
```

Update the routes to mount the engine. `authenticate` is used by Devise so only authenticated users will be able to access the route.

```ruby
# config/routes.rb
Rails.application.routes.draw do
  authenticate :user do
    mount Stripe::Subscribe::Engine => "/stripe/subscribe"
  end
end
```

Include the following module to the User model to give it Stripe related methods like `active_stripe_subscription?` and `stripe_customer`.

```ruby
# app/models/user.rb
class User < ApplicationRecord
  include Stripe::Subscriberable
end
```

To restrict access to the application by querying a user's stripe subscriptions. `stripe_subscribe.plans_path` will start the user on the subscription flow.

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
