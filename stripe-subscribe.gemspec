$LOAD_PATH.push File.expand_path('lib', __dir__)

# Maintain your gem's version:
require 'stripe/subscribe/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'stripe-subscribe'
  s.version     = Stripe::Subscribe::VERSION
  s.authors     = ['SengMing Tan']
  s.email       = ['sengming@sanemen.com']
  s.homepage    = 'https://github.com/tansengming/stripe-subscribe'
  s.summary     = 'A Rails Engine for easy Stripe Subscriptions'
  s.description = 'A Rails Engine for easy Stripe Subscriptions'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  s.add_dependency 'devise'
  s.add_dependency 'stripe-rails'
  s.add_development_dependency 'capybara'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'stripe-ruby-mock'
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'tapp'
end
