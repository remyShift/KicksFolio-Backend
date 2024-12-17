source "https://rubygems.org"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 8.0.0", ">= 8.0.0.1"

# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 5.0"

# Use the database-backed adapters for Rails.cache, Active Job, and Action Cable
gem "solid_cache"
gem "solid_queue"
gem "solid_cable"

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

group :development, :test do
  # FactoryBot for instance generation
  gem "factory_bot_rails"

  # Faker for generating random test data
  gem "faker"

  # Shoulda Matchers for RSpec for testing Rails models
  gem "shoulda-matchers", "~> 5.0"

  # Static analysis for security vulnerabilities [https://brakemanscanner.org/]
  gem "brakeman", require: false

  # Database cleaner for cleaning the database between tests
  gem "database_cleaner-active_record"

  # Ruby code style checker
  gem "rubocop"

  # RSpec for testing
  gem "rspec-rails", "~> 6.0"

  # Guard for running tests on file changes
  gem "guard"
  gem "guard-rspec", require: false
end
