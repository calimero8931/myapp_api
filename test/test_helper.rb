ENV['RAILS_ENV'] ||= 'test'
require_relative "../config/environment"
require "rails/test_help"

# gem minitest-reporters setup
require "minitest/reporters"
Minitest::Reporters.use!

class ActiveSupport::TestCase
  # 並列テスト とは複数のプロセスを分岐させテスト時間の短縮を行う機能
  #
  # プロセスが分岐した直後に呼び出し
  parallelize_setup do |worker|
    # seedデータの読み込み
    load "#{Rails.root}/db/seeds.rb"
  end

  # 並列テストの有効・無効化
  # workers: プロセス数を渡す(2以上 => 有効、2未満 => 無効)
  #number_of_processors => 使用しているマシンのコア数（今回の場合はDockerで4）
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...

  # アクティブユーザーを返す
  def active_user
    User.find_by(activated: true)
  end

  # api path
  def api(path = "/")
    "/api/v1#{path}"
  end

  # 認可ヘッダ
  def auth(token)
    { Authorization: "Bearer #{token}" }
  end

  # 引数のparamsでログインを行う
  def login(params)
    post api("/auth_token"), xhr: true, params: params
  end

  # ログアウトapi
  def logout
    delete api("/auth_token"), xhr: true
  end

  # レスポンスJSONをハッシュで返す
  def res_body
    JSON.parse(@response.body)
  end


end
