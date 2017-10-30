module DssDw
  require 'net/http'
  require 'json'

  DW_URL = ENV['DW_URL']
  DW_TOKEN = ENV['DW_TOKEN']

  def self.fetch_person_by_loginid(loginid)
    return nil unless loginid

    url = "#{DW_URL}/people/#{loginid}.json?token=#{DW_TOKEN}"
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri)

    begin
      response = http.request(request)
    rescue Errno::ECONNREFUSED => e
      STDERR.puts "Unable to connect to #{DW_URL}. Check that DW is running."
      return nil # Unable to connect to DW
    end

    return nil if response.code.to_i == 404

    begin
      json = JSON.parse(response.body)
    rescue JSON::ParserError => e
      return nil # not a 404 but JSON response did not make sense
    end

    return json # rubocop:disable Style/RedundantReturn
  end

  def self.fetch_pps_departments
    url = "#{DW_URL}/departments/pps.json?token=#{DW_TOKEN}"
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)

    return nil if response.code.to_i == 404

    begin
      json = JSON.parse(response.body)
    rescue JSON::ParserError => e
      return nil # not a 404 but JSON response did not make sense
    end

    return json # rubocop:disable Style/RedundantReturn
  end
end
