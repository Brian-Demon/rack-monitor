# Rack::Monitor

Rack Middleware that performs basic monitoring functionality in a pluggable fashion.

In this exercise, we're going to implement the following criteria:

- `GET /_ping` will return a 200 status with a body of `PONG`
- `GET /_boom` will return a 500 status with a body of `BOOM`
- `GET /_boom` will log an entry with the current time in `exceptions.log`
- Any other `GET` will continue on to the next Rack middleware

# Usage

Use `rake test` to run the tests and add whatever you think makes sense.  If you need to manually test the Rack middleware , use `bin/server` to spin up an example Rack server with the middleware installed.