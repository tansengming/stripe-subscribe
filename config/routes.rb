# TODO
# Rails.application.routes.draw do
#   if Rails.application.config.stripe.auto_mount
#     mount Stripe::Engine => Rails.application.config.stripe.endpoint
#   end
# end

Stripe::Subscribe::Engine.routes.draw do
  resources :plans,   only: :index
  resource  :payment, only: [:new, :create]
end
