source 'https://rubygems.org'
gem 'rails', '~> 3.2.11'
gem 'sqlite3'
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'execjs'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
  gem 'jquery-datatables-rails', :github => 'rweng/jquery-datatables-rails'
end
gem 'jquery-rails'
gem "thin", ">= 1.5.0", :group => [:development, :test]
gem "unicorn", ">= 4.3.1", :group => :production
gem "kaminari", '0.14.1'
gem "decent_exposure"
gem "haml", ">= 3.1.7"

group :development do
  gem "debugger"
  gem "haml-rails", ">= 0.3.5"
  gem "hpricot", ">= 0.8.6"
  gem "quiet_assets", ">= 1.0.1"
  gem "ruby_parser", ">= 3.1.1"
  gem "better_errors", ">= 0.3.2"
  gem "binding_of_caller", ">= 0.6.8"
  gem 'meta_request'
end

group :test do
  gem "capybara", ">= 2.0.2"
  gem "ffaker"
  gem "database_cleaner", ">= 0.9.1"
  gem "email_spec", ">= 1.4.0"
  gem 'simplecov', :require => false
end

gem "brakeman", :group => [:development, :test]
gem "rails_best_practices", :group => [:development, :test]
gem "rspec-rails", ">= 2.12.2", :group => [:development, :test]
gem "fabrication", ">= 2.3.0", :group => [:development, :test]
gem "bootstrap-sass", ">= 2.2.2.0"
gem "simple_form", ">= 2.0.4"
gem "figaro", ">= 0.5.3"
gem "hub", ">= 1.10.2", :require => nil, :group => [:development]
