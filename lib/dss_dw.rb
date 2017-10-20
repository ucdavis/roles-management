module DssDw
  require 'net/http'
  require 'json'

  DW_URL = ENV['DW_URL']
  DW_TOKEN = ENV['DW_TOKEN']

  def self.fetch_person_by_loginid(loginid, log = nil)
    return nil unless loginid

    url = "#{DW_URL}/people/#{loginid}.json?token=#{DW_TOKEN}"
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

    # person = Person.new
    # person.loginid = json['prikerbacct']['userId']
    # person.name = json['person']['oFullName']
    # person.first = json['person']['oFirstName']
    # person.last = json['person']['oLastName']
    # person.email = json['contactInfo']['email']
    # person.phone = json['contactInfo']['workPhone']
    # person.address = json['contactInfo']['addrStreet']

    # # TODO: Expand to support multiple majors
    # unless json['sisAssociations'].empty?
    #   # TODO: Make this a find_or_create_by()
    #   person.major = Major.find_by(name: json['sisAssociations'][0]['majorName'])
    # end
    # # TODO: Expand to support multiple titles
    # unless json['ppsAssociations'].empty?
    #   # TODO: Make this a find_or_create_by()
    #   person.title = Title.find_by(name: json['ppsAssociations'][0]['titleDisplayName'])
    # end
    # # IGNOREME (appears unused) has_one :student

    # #
    # # Calculate LDAP's 'affiliation' field
    # #
    # json['ppsAssociations'].each do |assoc|
    #   if assoc['positionType'] == 'Regular/Career'
    #     puts 'AFF: Suggesting staff:career'
    #   end
    #   if [4919, 4920, 4921, 4923, 4924, 4925, 4954, 4955, 4956, 4957].include? assoc['titleCode'].to_i
    #     puts 'AFF: Suggesting staff:student'
    #   end
    # end
    # if json['person']['isFaculty'] == true
    #   puts 'AFF: Suggesting faculty'
    # end
    # if json['person']['isStaff'] == true
    #   puts 'AFF: Suggesting staff'
    # end
    # json['sisAssociations'].each do |assoc|
    #   if assoc['levelCode'] == 'UG'
    #     puts 'AFF: Suggesting student:undergraduate'
    #   elsif assoc['levelCode'] == 'GR'
    #     puts 'AFF: Suggesting student:graduate'
    #   end
    # end
  end
end
