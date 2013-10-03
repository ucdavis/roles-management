if defined? Rack and defined? Rack::Timeout
  Rack::Timeout.timeout = 60  # seconds
end
