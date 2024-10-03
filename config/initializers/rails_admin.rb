RailsAdmin.config do |config|
  # Webpackerを使っている場合の設定
  config.asset_source = :webpacker

  ### Deviseによる認証
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)

  ### CancanCanによる認可
  config.authorize_with :cancancan

  ### カスタムレイアウトの指定
  # 親コントローラーとしてApplicationControllerを指定
  config.parent_controller = 'ApplicationController'

  ### 必要なアクションの定義
  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app
  end
end