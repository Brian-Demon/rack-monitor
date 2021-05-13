require "rack"

module Rack
  class Monitor
    class Error < StandardError; end
    # Your code goes here...
    def initialize(app)
      @app = app
    end

    def call(env)
      
    end
  end
end
