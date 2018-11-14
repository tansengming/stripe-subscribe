# Stripe::Subscribe: Stripe subscriptions made easy.

This is a Rails Engine that makes it easier to get started with Stripe Subscriptions. You can fetch a user's subscription information and send them to a subscription page this way.

```ruby
# app/controllers/paid_features_controller.rb
class PaidFeaturesController < ApplicationController
  def show
    if current_user.active_stripe_subcsriptions? # fetches subscription details from Stripe.
      render
    else
      redirect_to stripe_subscribe.plans_path # Customizable views where users can select and pay for plan.
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

Start by installing and running the migrations on the command line,

```bash
rails stripe_subscribe:install:migrations
rails db:migrate
```

Then create a new file to store and submit your plans at `config/stripe/plans.rb`. This will be posted to Stripe and used to render the plans view of the engine.

```ruby
# config/stripe/plans.rb
Stripe.plan :pro do |plan|
  plan.name = 'Acme as a service PRIMO'
  plan.amount = 699
  plan.interval = 'month'
end
```

Then run `rake stripe:prepare` to upload the plan to Stripe

Next update the routes to point to the engine, note the call to `authenticate` is used by Devise to make sure only authenticated users will be able to access the route.

```ruby
# config/routes.rb
Rails.application.routes.draw do
  authenticate :user do
    mount Stripe::Subscribe::Engine => "/stripe/subscribe"
  end
end
```

Include the following module to the User model to give it Stripe related methods like `active_stripe_subscription?`, `stripe_customer` etc

```ruby
# app/models/user.rb
class User < ApplicationRecord
  include Stripe::Subscriberable
end
```

Finally, you will be able to restrict access to your application by querying a user's stripe subscriptions. `stripe_subscribe.plans_path` will start the user on the subscription flow.

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
