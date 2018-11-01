Rails.application.routes.draw do
  devise_for :users
  mount Stripe::Subscribe::Engine => "/stripe-subscribe"
end
