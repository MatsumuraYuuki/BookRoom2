require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module BookRoom2
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    config.generators do |g| # 追記
      g.assets false          # CSS, JavaScriptファイルを自動生成しない
      g.helper     false      # helperファイルを自動生成しない
      g.test_framework :rspec, # ここから5行を追記
      fixtures: false, # テストDBにレコードを作るfixtureの作成をスキップ(FactoryBotを使用するため)
      view_specs: false, # ビューファイル用のスペックを作成しない
      helper_specs: false, # ヘルパーファイル用のスペックを作成しない
      routing_specs: false # routes.rb用のスペックファイル作成しない
    end
  end
end
