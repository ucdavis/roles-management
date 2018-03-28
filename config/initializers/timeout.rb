if defined? Rack and defined? Rack::Timeout
  Rack::Timeout.timeout = 120  # seconds
end
