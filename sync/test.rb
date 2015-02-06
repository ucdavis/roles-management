#! /usr/bin/env ruby

require 'json'

begin
  @sync_data = JSON.parse(STDIN.read)
rescue JSON::ParserError
  abort "JSON::ParserError: Input does not appear to be valid JSON."
end

require 'pp'

puts "Sync Data given to script:"
pp @sync_data

exit(0)
