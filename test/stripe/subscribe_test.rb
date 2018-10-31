require 'test_helper'

class Stripe::Subscribe::Test < ActiveSupport::TestCase
  test "truth" do
    assert_kind_of Module, Stripe::Subscribe
  end
end
