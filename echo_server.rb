# frozen_string_literal: true

class EchoServer
  def initialize(options = {}); end

  def call(env)
    headers = env.each_with_object({}) do |header, values|
      k, v = header
      values[k.sub(/^HTTP_/, '')] = v if k.start_with?('HTTP_') && (k != 'HTTP_VERSION')
    end

    body = headers.collect { |k, v| "#{k}: #{v}" }.join("\r\n")
    body = "#{body}\r\n\r\n#{env['rack.input'].read}"

    [200, headers, [body]]
  end
end
