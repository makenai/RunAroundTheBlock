source 'https://rubygems.org'

gem 'rails', '3.2.13'
gem 'runkeeper'
gem 'omniauth-runkeeper', github: 'srhaber/omniauth-runkeeper'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

group :development do
  gem 'sqlite3'
  gem 'zappos-deploy', git: 'git@github.zappos.net:shaber/zappos-deploy.git'
end

group :development, :test do
  gem 'rspec-rails'
end

group :staging, :production do
  gem "mysql2"
end
