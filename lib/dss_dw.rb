module DssDw
  require 'net/https'
  require 'json'
  require 'uri'

  # Custom exception used in module
  class DssDwError < StandardError
  end

  def self.fetch_person_by_loginid(loginid)
    return nil unless loginid

    response = perform_dw_request("/people/#{loginid}.json")

    return nil if response.nil?
    return nil if response.code.to_i == 404

    begin
      json = JSON.parse(response.body)
    rescue JSON::ParserError
      return nil # not a 404 but JSON response did not make sense
    end

    return json # rubocop:disable Style/RedundantReturn
  end

  def self.fetch_pps_departments
    response = perform_dw_request('/departments/pps.json')

    return nil if response.nil?
    return nil if response.code.to_i == 404

    begin
      json = JSON.parse(response.body)
    rescue JSON::ParserError
      return nil # not a 404 but JSON response did not make sense
    end

    return json # rubocop:disable Style/RedundantReturn
  end

  def self.fetch_people_by_pps_department(dept_code)
    response = perform_dw_request("/departments/pps/#{dept_code}")

    return nil if response.nil?
    return nil if response.code.to_i == 404

    begin
      json = JSON.parse(response.body)
    rescue JSON::ParserError
      return nil # not a 404 but JSON response did not make sense
    end

    return json # rubocop:disable Style/RedundantReturn
  end

  def self.search_people(query)
    return nil unless query

    response = perform_dw_request("/people/search?q=#{URI.escape(query)}")

    return nil if response.nil?
    return nil if response.code.to_i == 404

    begin
      json = JSON.parse(response.body)
    rescue JSON::ParserError
      return nil # not a 404 but JSON response did not make sense
    end

    return json # rubocop:disable Style/RedundantReturn
  end

  # path, e.g. /people/search?q=something
  # Token will be added automatically.
  def self.perform_dw_request(path)
    raise DssDwError, 'DW_URL and/or DW_TOKEN environment variable(s) missing' if dw_url.blank? || dw_token.blank?

    # Determine if SSL is needed
    https_mode = dw_url.start_with? 'https'

    url = "#{dw_url}#{path}"

    # Determine if 'url' contains parameters
    url += if url.include?('?')
      "&token=#{dw_token}"
    else
      "?token=#{dw_token}"
    end

    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)

    if https_mode
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    end

    request = Net::HTTP::Get.new(uri.request_uri)

    begin
      response = http.request(request)
    rescue Errno::ECONNREFUSED
      STDERR.puts "Unable to connect to #{dw_url}"
      return nil
    rescue Net::OpenTimeout
      STDERR.puts "Request timed out (Net::OpenTimeout): #{dw_url}"
      return nil
    rescue Net::ReadTimeout
      STDERR.puts "Request timed out (Net::ReadTimeout): #{dw_url}"
      return nil
    end

    return response # rubocop:disable Style/RedundantReturn
  end

  # Creates or updates a person from DW using 'loginid'
  # If missing from DW, will not create a blank person with 'loginid'
  def self.create_or_update_using_dw(loginid)
    Rails.logger.debug "Create/update '#{loginid}' from DW ..."

    dw_person = DssDw.fetch_person_by_loginid(loginid)

    return nil unless dw_person

    p = Person.find_or_create_by(loginid: loginid)

    # Process the isStaff, isFaculty, etc. flags
    p.is_employee = dw_person['person']['isEmployee']
    p.is_hs_employee = dw_person['person']['isHSEmployee']
    p.is_faculty = dw_person['person']['isFaculty']
    p.is_student = dw_person['person']['isStudent']
    p.is_staff = dw_person['person']['isStaff']
    p.is_external = dw_person['person']['isExternal']
    p.iam_id = dw_person['person']['iamId'].to_i
    p.name = dw_person['person']['dFullName']
    p.first = dw_person['person']['dFirstName']
    p.last = dw_person['person']['dLastName']
    if dw_person['contactInfo']
      p.email = dw_person['contactInfo']['email']
      p.phone = dw_person['contactInfo']['workPhone']
      p.address = dw_person['contactInfo']['postalAddress']
    end
    p.synced_at = dw_person['person']['lastSeen'] || p.synced_at

    # Process any majors (SIS associations)
    begin
      existing_sis_assocs = p.sis_associations.map do |assoc|
        {
          id: assoc.id,
          major: assoc.major.name,
          association_rank: assoc.association_rank,
          level_code: assoc.level_code
        }
      end

      dw_person['sisAssociations'].uniq.each do |sis_assoc_json|
        next if sis_assoc_json.nil?
        next unless existing_sis_assocs.reject! do |assoc|
          assoc[:major] == sis_assoc_json['majorName'] &&
          assoc[:association_rank] == sis_assoc_json['assocRank'].to_i &&
          assoc[:level_code] == sis_assoc_json['levelCode']
        end.nil?

        # Create new SIS association
        SisAssociation.create!(entity_id: p.id,
                               major: Major.find_by(name: sis_assoc_json['majorName']),
                               association_rank: sis_assoc_json['assocRank'].to_i,
                               level_code: sis_assoc_json['levelCode'])
      end

      existing_sis_assocs.each do |assoc|
        # Destroy old SIS associations
        p.sis_associations.destroy(SisAssociation.find_by(id: assoc[:id]))
      end
    rescue ActiveRecord::RecordNotSaved => e
      Rails.logger.error "Could not save SIS associations for #{p.loginid}. Exception trace:"
      Rails.logger.error e
    end

    begin
      # Process any PPS associations
      existing_pps_assocs = p.pps_associations.map do |assoc|
        {
          id: assoc.id,
          title: assoc.title.code,
          department: assoc.department.code,
          admin_department: assoc.admin_department&.code,
          appt_department: assoc.appt_department&.code,
          association_rank: assoc.association_rank,
          position_type_code: assoc.position_type_code
        }
      end
      dw_person['ppsAssociations'].uniq.each do |pps_assoc_json|
        next if pps_assoc_json.nil?
        next unless existing_pps_assocs.reject! do |assoc|
          assoc[:title] == pps_assoc_json['titleCode'] &&
          assoc[:department] == pps_assoc_json['deptCode'] &&
          assoc[:admin_department] == pps_assoc_json['adminDeptCode'] &&
          assoc[:appt_department] == pps_assoc_json['apptDeptCode'] &&
          assoc[:association_rank] == pps_assoc_json['assocRank'].to_i &&
          assoc[:position_type_code] == pps_assoc_json['positionTypeCode'].to_i
        end.nil?

        # New PPS association found
        begin
          PpsAssociation.create!(person_id: p.id,
                                 title: Title.find_by(code: pps_assoc_json['titleCode']),
                                 department: Department.find_by(code: pps_assoc_json['deptCode']),
                                 admin_department: Department.find_by(code: pps_assoc_json['adminDeptCode']),
                                 appt_department: Department.find_by(code: pps_assoc_json['apptDeptCode']),
                                 association_rank: pps_assoc_json['assocRank'].to_i,
                                 position_type_code: pps_assoc_json['positionTypeCode'].to_i)
        rescue ActiveRecord::RecordInvalid => e
          Rails.logger.error 'Could not create a PpsAssociation for person, skipping ...'
          Rails.logger.error "\tPerson        : #{p.id}, #{p.loginid}"
          Rails.logger.error "\tPPS Assocation: #{pps_assoc_json.inspect}"
          Rails.logger.error "\tError         : #{e.inspect}"
        end
      end

      existing_pps_assocs.each do |assoc|
        # Destroy old PPS associations
        p.pps_associations.destroy(PpsAssociation.find_by(id: assoc[:id]))
      end
    rescue ActiveRecord::RecordNotSaved => e
      Rails.logger.error "Could not save PPS associations for #{p.loginid}. Ensure PPS departments are imported."
      Rails.logger.error 'Exception trace:'
      Rails.logger.error e
    end

    p.save!

    return p # rubocop:disable Style/RedundantReturn
  end

  def self.dw_url
    @@DW_URL ||= ENV['DW_URL']
    @@DW_URL ||= Rails.application.secrets[:dw_url]
  end

  def self.dw_token
    @@DW_TOKEN ||= ENV['DW_TOKEN']
    @@DW_TOKEN ||= Rails.application.secrets[:dw_token]
  end
end
