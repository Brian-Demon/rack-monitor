require "rack"

module Rack
  class Monitor
    class Error < StandardError; end
    def initialize(app, log_path)
      @app = app
      @log_path = log_path
    end

    def call(env)
      request_method = env["REQUEST_METHOD"]
      if request_method == "GET"
         return get(env)
      end
      @app.call(env)
    end

    def get(env)
      case env["PATH_INFO"]
      when "/_ping"
       return [200, {}, ["PONG"]]
      when "/_boom"
       ::File.open(@log_path, "a+") do |line|
         line << "#{Time.now}\n"
       end
       return [500, {}, ["BOOM"]]
      else
        @app.call(env)
      end
    end
  end
end