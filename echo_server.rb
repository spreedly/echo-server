class EchoServer

  def initialize(options = {})
  end

  def call(env)

    headers = env.inject({}) do |values, header|
      k, v = header
      values[k.sub(/^HTTP_/, '')] = v if k.start_with? 'HTTP_' and k != 'HTTP_VERSION'
      values
    end

    body = headers.collect { |k, v| "#{k}: #{v}" }.join("\r\n")
    body = "#{body}\r\n\r\n#{env["rack.input"].read}"

    [200, headers, [body]]
  end
end
