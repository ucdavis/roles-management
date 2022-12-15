module Uinform
    require 'net/https'
    require 'json'
    require 'uri'
    require 'base64'
    require 'openssl'

    class UinformError < StandardError
    end

    def self.configure
        @base_url = ENV['UINFORM_BASE_URL']
        @private_key = ENV['UINFORM_PRIVATE_KEY']
        @public_key = ENV['UINFORM_PUBLIC_KEY']
    end

    def self.create_signature(method, timestamp)
        raw_signature = "#{method}:#{timestamp}:#{@public_key}"
        bytes = OpenSSL::HMAC.digest('sha1', @private_key, raw_signature)
        signature = Base64.strict_encode64(hmac)
    end

    def self.http_get(url)
        uri = URI.parse(url)
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true

        request = Net::HTTP::Get.new(uri.request_uri)

        timestamp = Time.now.utc.to_i
        request['X-UTIMESTAMP'] = timestamp
        signature = self.create_signature('GET', timestamp)
        request['Authorization'] = "Basic " + Base64::strict_encode64("#{@public_key}:#{signature}")

        response = http.request(request)

        return nil if response.code.to_i == 404

        begin
          json = JSON.parse(response.body)
        rescue JSON::ParserError
          return nil # not a 404 but JSON response did not make sense
        end
    
        return json['responseObject']
    end

    def self.get_user_by_login(loginid)
        endpoint = @base_url + "/AdUsers/sam/" + loginid
        self.http_get(endpoint)
    end

    def self.find_guid_by_group_name(group_name)
        url = "/ManagedGroups/search"
    end

    def self.get_group(group_name)
    end

    def self.add_user_to_group(user, group)
    end

    def self.remove_user_from_group(user, group)
    end

    def self.update_group_description(group, description)
    end

    def self.list_group_members(group)
    end
end