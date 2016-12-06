source 'https://rubygems.org'
source 'https://rails-assets.org' 

ruby '2.3.2'

gem 'rails', '4.2.7'
#pg instead of sqlite 3, sqilte3 doesn't have timestamp to order weekly, pg is more likely prod similar db
gem 'pg'
#gem 'sqlite3'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'rails-assets-nvd3'
gem 'bootstrap-sass', '~> 3.3.7'
gem 'haml-rails'
gem 'font-awesome-rails', '~> 4.7'
#state_machines-active-record to create real application states for applicants
gem 'state_machines-activerecord', '~> 0.4.0'
gem 'faker', '~> 1.6'

group :development do
  gem 'better_errors', '~> 2.1.1'
  gem 'html2haml'
  gem 'quiet_assets'
  gem 'rails_layout'
  gem 'byebug'
  gem 'web-console', '~> 2.0'
  gem 'spring'
end

#testing gems
group :development, :test do
  gem 'rspec-rails', '~> 3.5'
  gem 'capybara', '~> 2.10.1'
  gem 'factory_girl_rails', '~> 4.7'
  gem 'database_cleaner', '~> 1.5'  
  gem 'simplecov'
end