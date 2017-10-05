require_relative "../client"

require 'net/http'
require 'uri'

module Twizo

  class NetHttpClient < Client

    #
    # @param [String] method
    # @param [String] location
    #
    # @return [Object]
    #
    def send_request(method, location, post_params)
      uri = URI.parse("https://#{@api_host}/#{Client::API_VERSION}/#{location}")

      case method
        when 'GET'
          request = Net::HTTP::Get.new(uri)
        when 'POST'
          request = Net::HTTP::Post.new(uri)
        when 'PUT'
          request = Net::HTTP::Put.new(uri)
        when 'DELETE'
          request = Net::HTTP::Delete.new(uri)
        else
          raise RuntimeError.new('No method provided')
      end

      request.add_field('user-agent', user_agent)
      request.basic_auth(API_USERNAME, @api_key)
      request.content_type = 'application/json; charset=utf8'
      request['accept'] = 'application/json'

      request.body = post_params unless post_params.nil?

      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true

      https.request(request)

    end

  end

end