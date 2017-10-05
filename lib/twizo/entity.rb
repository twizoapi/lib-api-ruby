require "twizo/result"
require "twizo/twizo_error"

=begin

 This file is part of the Twizo php api

 (c) Twizo <info@twizo.com>

 For the full copyright and license information, please view the LICENSE
 File that was distributed with this source code.

=end

module Twizo

  class Entity

    #
    # http method actions
    #
    ACTION_CREATE = 'POST'
    ACTION_UPDATE = 'PUT'
    ACTION_RETRIEVE = 'GET'
    ACTION_REMOVE = 'DELETE'

    #
    # Constructor
    #
    # @param [Client] client
    #
    def initialize(client)
      @client = client
    end

    #
    # @param [String] id
    # @param [String|null] widget_recipient
    # @param [String|null] widget_backup_code_id
    #
    # @return [Object]
    #
    def populate(id, widget_recipient = nil, widget_backup_code_id = nil)
      raise 'Error: id not provided' unless id

      params = id
      params += "?recipient=#{widget_recipient}" if widget_recipient
      params += "&backupCodeIdentifier=#{widget_backup_code_id}" if widget_backup_code_id

      response = send_api_call(ACTION_RETRIEVE, "#{location}/#{params}")

      raise response if response.kind_of?(TwizoError)

      response_to_array(response)
    end

    private

    #
    # @param [String] method
    # @param [String] location
    # @param [Object|null] post_params
    #
    # @return [Object]
    #
    def send_api_call(method, location, post_params = nil)
      response = @client.send_request(method, location, post_params)

      case Integer(response.code)
        when 200, 201
          JSON.parse(response.body)
        when 204
          response
        else
          raise TwizoError.new(response.code, JSON.parse(response.body))
      end
    end

    #
    # @param [Object] response
    # @param [String|null] field
    #
    # @return [Object]
    #
    def response_to_array(response, field = nil)

      parent_items = response.reject { |key| key == '_embedded' }

      results = Result.new(parent_items)

      if field
        child_items = response['_embedded'][field]

        if child_items.kind_of?(Array)

          child_items.each do |item|
            results.add_result(Result.new(item))
          end

        else

          results.add_result(Result.new(child_items))

        end

      end

      results
    end

  end

end

