require_relative 'echo_server'

use Rack::Runtime
run EchoServer.new
