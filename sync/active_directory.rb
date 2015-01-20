#! /usr/bin/env ruby

require 'json'

puts "active_directory.rb sync beginning ..."

begin
  sync_data = JSON.parse(STDIN.read)
rescue JSON::ParserError
  abort "JSON::ParserError: Input does not appear to be valid JSON."
end

require 'pp'
pp sync_data

case sync_data["mode"]
when "add_to_system"

when "remove_from_system"

when "add_to_role"

when "remove_from_role"

when "activate_person"

when "deactivate_person"

else
  abort "This script does not understand sync mode: #{sync_data["mode"]}"
end
