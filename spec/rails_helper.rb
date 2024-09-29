require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'

abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rspec/rails'
require 'capybara/rspec'
require 'selenium/webdriver'
require 'webdrivers'

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.strip
end

RSpec.configure do |config|
  config.fixture_path = Rails.root.join('spec/fixtures')

  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!

  config.include FactoryBot::Syntax::Methods
  config.include Devise::Test::IntegrationHelpers, type: :system

  # Capybaraの設定
  Capybara.default_driver = :selenium_chrome # 通常のChromeを使用
  Capybara.javascript_driver = :selenium_chrome # JSを含むテストでChromeを使用

  # ヘッドレスモード（ブラウザ画面を表示しないモード）を使用したい場合
  Capybara.register_driver :selenium_chrome_headless do |app|
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--headless')
    options.add_argument('--disable-gpu')
    options.add_argument('--no-sandbox') # Linux環境で必要な場合あり
    options.add_argument('--disable-dev-shm-usage') # メモリ共有の問題を回避

    Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
  end

  # Capybaraのテストのタイムアウト時間を設定
  Capybara.default_max_wait_time = 5 # 5秒（必要に応じて調整）

  config.before(:each, type: :system) do
    driven_by :selenium_chrome_headless # ヘッドレスモードで実行する
  end

end
