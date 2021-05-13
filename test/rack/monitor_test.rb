require "test_helper"

class Rack::MonitorTest < Minitest::Test
  include Rack::Test::Methods

  def exception_log
    File.open("exceptions.log", "a+")
  end

  def exception_log_length
    file = exception_log
    length = file.read.length
    file.close
    length
  end

  def app
    builder = Rack::Builder.new
    builder.use Rack::Monitor
    builder.run lambda { |env| [200, {}, ["Welcome!"]]}
  end

  def test_ping_responds_pong
    get "/_ping"

    assert last_response.ok?
    assert_equal last_response.body, "PONG"
  end

  def test_boom_responds_500
    get "/_boom"

    assert_equal 500, last_response.status
  end

  def test_boom_logs_to_exception_log
    exception_count = exception_log_length
    get "/_boom"

    assert_equal exception_count+1, exception_log_length
  end

  def test_passes_through_requests
    get "/foo"
    
    assert last_response.ok?
    assert_equal "Welcome!", last_response.body
  end
end
