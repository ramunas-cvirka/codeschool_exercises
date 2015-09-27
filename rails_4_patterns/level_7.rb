# 7.2 Pluck
class Item < ActiveRecord::Base

  def self.recent
    where('published_on > ?', 2.days.ago).pluck(:id, :name)
  end
end

# 7.3 Sensitive Parameters
class Rails4Patterns::Application
  # hiding other config for brevity...
  config.filter_parameters += [:password, :security_answer]
end

# 7.4 Set Application Server
source 'https://rubygems.org'

gem 'rails', '4.0.0'
gem 'puma'
gem 'sqlite3'
gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'

group :doc do
  gem 'sdoc', require: false
end

# 7.5 Set Ruby Version
source 'https://rubygems.org'

ruby '2.0.0'
gem 'rails', '4.0.0'
gem 'sqlite3'
gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'

group :doc do
  gem 'sdoc', require: false
end

gem 'puma'

# 7.6 Basic Procfile
web: bundle exec rails s -p $PORT

# 7.7 Advanced Procfile
web: bundle exec rails s -p $PORT
worker: bundle exec rake worker
urgent_worker: bundle exec rake urgent_worker
scheduler:  bundle exec rake scheduler
