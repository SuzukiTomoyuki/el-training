source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.6'
# Use mysql as the database for Active Record
gem 'mysql2', group: [:development, :test]
group :production do
  gem 'pg'
  # heroku上でassetsをうまく取り扱うためのものだったはず
  gem 'rails_12factor'
  gem 'mysql2'
  gem 'capistrano', '~> 3.7.0'
  gem 'capistrano-rails'
  gem 'capistrano-rbenv'
  gem 'capistrano-bundler'
end
# Use Puma as the app server
gem 'puma', '~> 3.7'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', groups: :development

# NOTE: View handlerの設定で使用されるのでどの環境でも必要
gem 'slim'
#
# ステートマシン
gem 'aasm'
#
# ページネーション
gem 'kaminari'

# Use jquery as the JavaScript library
gem 'jquery-rails'

gem 'bootstrap-sass', '~> 3.3.6'

# gem 'rails-i18n'

# トースター
gem 'toastr-rails'

# 確認ダイアログ
gem 'data-confirm-modal'

gem 'bcrypt', '~> 3.1.7'

# 画像アップロード
gem 'carrierwave'
gem 'fog'

# erbをスリムに変換
gem 'html2slim'

gem "jquery-turbolinks"
gem 'select2-rails'

gem 'ruby-debug-ide'
gem 'debase'

# gmail
gem 'figaro'

# google drive
gem 'google_drive'
#dropbox
gem 'dropbox-sdk'
gem 'omniauth-dropbox-oauth2'
gem 'dotenv-rails'
gem 'dropbox_api'
gem 'dropbox-sdk-v2'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]

  gem 'rspec-rails'
  gem "factory_girl_rails"
  gem 'brakeman', require: false
end

group :test do
  gem 'capybara'
  # gem 'capybara-webkit'
  gem 'database_rewinder'
  # gem 'database_cleaner'
  gem 'selenium-webdriver'
  gem 'chromedriver-helper'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
