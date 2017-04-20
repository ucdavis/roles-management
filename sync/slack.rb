#! /usr/bin/env ruby

require 'json'
require 'slack-notifier'
require 'yaml'

begin
  @sync_data = JSON.parse(STDIN.read)
rescue JSON::ParserError
  abort "JSON::ParserError: Input does not appear to be valid JSON."
end

@config = YAML.load_file(@sync_data["config_path"] + "/slack.yml")

notifier = Slack::Notifier.new @config["webhook_url"], channel: @config["channel"], username: @config["username"]

case @sync_data["mode"]

  when "add_to_system"
    notifier.ping "*" + @sync_data["person"]["name"] + "* added to RM system"
    exit(0)

  when "remove_from_system"
    notifier.ping "*" + @sync_data["person"]["name"] + "* removed from RM system"
    exit(0)

  when "add_to_role"
    notifier.ping "*" + @sync_data["person"]["name"] + "* added to role *" + @sync_data["role"]["application_name"] + " / " + @sync_data["role"]["role_name"] + "*"
    exit(0)

  when "remove_from_role"
    notifier.ping "*" + @sync_data["person"]["name"] + "* removed from role *" + @sync_data["role"]["application_name"] + " / " + @sync_data["role"]["role_name"] + "*"
    exit(0)

  when "add_to_organization"
    notifier.ping "*" + @sync_data["person"]["name"] + "* added to organization *" + @sync_data["organization"]["name"] + "*"
    exit(0)

  when "remove_from_organization"
    notifier.ping "*" + @sync_data["person"]["name"] + "* removed from organization *" + @sync_data["organization"]["name"] + "*"
    exit(0)

  when "role_change"
    # Don't notify for this type of sync event (e.g. a role's AD path changing)
    exit(0)

  else
    abort "This script does not understand sync mode: #{@sync_data["mode"]}"
end

# We will only get here on error.
exit(1)
