Rails.application.routes.draw do
  devise_for :users

  authenticate :user do
    mount Stripe::Subscribe::Engine => "/stripe/subscribe"
  end
end
