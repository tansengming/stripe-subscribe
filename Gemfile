source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Declare your gem's dependencies in stripe-subscribe.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.

# To use a debugger
# gem 'byebug', group: [:development, :test]

# Note: The following lines are require for rails specs to run even though
# they're repeated from the gemspec.

gem 'rails', '~> 5.2.0'
gem 'devise'
gem "stripe-rails"
gem 'bootstrap'
gem 'sqlite3'
gem 'haml-rails'
gem 'reform-rails'

group :test do
  gem 'rspec-rails'
  gem 'capybara'
end
