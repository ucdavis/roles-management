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

  def self.search_by(field, query)
    endpoints = {
      "full" => "iam/people/search?",
      "first" => "iam/people/search?dFirstName=",
      "last" => "iam/people/search?dFirstName=",
      "login" => "iam/people/prikerbacct/search?userId=",
      "email" => "iam/people/contactinfo/search?email="
    }

    if field == "full"
      names = query.split(" ")
      params = "dFirstName=#{names.first}&dLastName=#{names.last}"
    else
      params = query
    end

    fetch(endpoints[field] + params)
  end

  # Returns hash of userId, email, dFullName
  def self.search_people(query)
    results = {}
    threads = []
  
    threads << Thread.new { results[:fullName] = search_by("full", query) }
    threads << Thread.new { results[:firstName] = search_by("first", query) }
    threads << Thread.new { results[:lastName] = search_by("last", query) }
    threads << Thread.new { results[:email] = search_by("email", query) }
    threads << Thread.new { results[:loginid] = search_by("login", query) }
    threads.each(&:join)

    iam_ids = results.values.flatten.compact.map { |res| res["iamId"] }.uniq.take(10)

    users = iam_ids.map do |iam_id|
      user = {}
      p = fetch_person_by_iam_id(iam_id)
      user["userId"] = p["userId"]
      user["email"] = p["campusEmail"]
      user["dFullName"] = p["dFullName"]

      user
    end
    
    users
  end

  # Returns hash of contactInfo, ppsAssociations, person, prikerbacct, sisAssociations
  def self.fetch_person_by_loginid(loginid)
    p = search_by('login', loginid)
    iam_id = p[0]["iamId"]

    results = {}
    threads = []

    threads << Thread.new { results["contactInfo"] = fetch_contact_by_iam_id(iam_id) }
    threads << Thread.new { results["ppsAssociations"] = fetch_pps_associations_by_iam_id(iam_id) }
    threads << Thread.new { results["person"] = fetch_person_by_iam_id(iam_id) }
    threads << Thread.new { results["prikerbacct"] = fetch_kerb_by_iam_id(iam_id) }
    threads << Thread.new { results["sisAssociations"] = fetch_sis_associations_by_iam_id(iam_id) }

    threads.each(&:join)

    results
  end

  def self.fetch_contact_by_iam_id(iam_id)
    fetch("iam/people/contactinfo/#{iam_id}")[0]
  end

  def self.fetch_pps_associations_by_iam_id(iam_id)
    fetch("iam/associations/pps/#{iam_id}")
  end

  def self.fetch_person_by_iam_id(iam_id)
    fetch("iam/people/#{iam_id}")[0]
  end

  def self.fetch_kerb_by_iam_id(iam_id)
    fetch("iam/people/prikerbacct/#{iam_id}")[0]
  end

  def self.fetch_sis_associations_by_iam_id(iam_id)
    fetch("iam/associations/sis/#{iam_id}")
  end

  def self.fetch(path)
    raise UcdIamError, 'IAM_URL and/or IAM_API_KEY environment variable(s) missing' if iam_url.blank? || iam_api_key.blank?

    url = "#{iam_url}/api/#{path}#{path.include?("?") ? "&" : "?"}key=#{iam_api_key}&v=1.0"
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

    return json["responseData"]["results"]
  end

  def self.iam_url
    @@IAM_URL ||= ENV['IAM_URL']
  end

  def self.iam_api_key
    @@IAM_API_KEY ||= ENV['IAM_API_KEY']
  end
end
