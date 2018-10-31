Rails.application.routes.draw do
  mount Stripe::Subscribe::Engine => "/stripe-subscribe"
end
