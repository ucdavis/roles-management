module UcdIam
  require 'net/https'
  require 'json'

  # Custom exception used in module
  class UcdIamError < StandardError
  end

  def self.fetch_sis_majors
    raise UcdIamError, 'IAM_URL and/or IAM_API_KEY environment variable(s) missing' if iam_url.blank? || iam_api_key.blank?

    url = "#{iam_url}/api/iam/orginfo/sis/majors?key=#{iam_api_key}&v=1.0"
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)

    return nil if response.code.to_i == 404

    begin
      json = JSON.parse(response.body)
    rescue JSON::ParserError
      return nil # not a 404 but JSON response did not make sense
    end

    return json['responseData']['results'] # rubocop:disable Style/RedundantReturn
  end

  def self.fetch_bous
    raise UcdIamError, 'IAM_URL and/or IAM_API_KEY environment variable(s) missing' if iam_url.blank? || iam_api_key.blank?

    url = "#{iam_url}/api/iam/orginfo/pps/divisions?key=#{iam_api_key}&v=1.0"
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)

    return nil if response.code.to_i == 404

    begin
      json = JSON.parse(response.body)
    rescue JSON::ParserError
      return nil # not a 404 but JSON response did not make sense
    end

    return json['responseData']['results'] # rubocop:disable Style/RedundantReturn
  end

  def self.get_email_by_iam_id(iam_id)
    raise UcdIamError, 'IAM_URL and/or IAM_API_KEY environment variable(s) missing' if iam_url.blank? || iam_api_key.blank?

    url = "#{iam_url}/api/iam/people/contactinfo/#{iam_id}?key=#{iam_api_key}&v=1.0"
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)

    return nil if response.code.to_i == 404

    begin
      json = JSON.parse(response.body)
    rescue JSON::ParserError
      return nil # not a 404 but JSON response did not make sense
    end

    return json.dig('responseData', 'results', 0, 'email')
  end

  def self.get_login_by_iam_id(iam_id)
    raise UcdIamError, 'IAM_URL and/or IAM_API_KEY environment variable(s) missing' if iam_url.blank? || iam_api_key.blank?

    url = "#{iam_url}/api/iam/people/prikerbacct/#{iam_id}?key=#{iam_api_key}&v=1.0"
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)

    return nil if response.code.to_i == 404

    begin
      json = JSON.parse(response.body)
    rescue JSON::ParserError
      return nil # not a 404 but JSON response did not make sense
    end

    return json.dig('responseData', 'results', 0, 'userId')
  end

  def self.iam_url
    @@IAM_URL ||= ENV['IAM_URL']
    @@IAM_URL ||= Rails.application.secrets[:iam_url]
  end

  def self.iam_api_key
    @@IAM_API_KEY ||= ENV['IAM_API_KEY']
    @@IAM_API_KEY ||= Rails.application.secrets[:iam_api_key]
  end
end
