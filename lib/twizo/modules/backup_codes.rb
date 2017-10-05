require_relative 'params/backup_codes_params'

=begin

 This file is part of the Twizo php api

 (c) Twizo <info@twizo.com>

 For the full copyright and license information, please view the LICENSE
 File that was distributed with this source code.

=end

module Twizo

  module BackupCodes

    #
    # Getter for params
    #
    attr_reader :params

    #
    # @param [String] identifier
    #
    def set(identifier)
      @params = BackupCodesParams.new
      @params.identifier = identifier
    end

    #
    # Send message to the server and return response
    #
    # @return [Object]
    #
    def send
      post_params = @params.to_json

      response = send_api_call(Entity::ACTION_CREATE, location, post_params)

      raise response if response.kind_of?(TwizoError)

      response_to_array(response)
    end

    #
    # @param [String] backup_code
    #
    # @return [Object]
    #
    def verify(backup_code)
      response = send_api_call(Entity::ACTION_RETRIEVE, "#{location}/#{@params.identifier}?token=#{backup_code}")

      raise response if response.kind_of?(TwizoError)

      response_to_array(response)
    end

    #
    # Update de backup codes
    #
    # @return [Object]
    #
    def update
      post_params = @params.to_json

      response = send_api_call(Entity::ACTION_UPDATE, "#{location}/#{@params.identifier}", post_params)

      raise response if response.kind_of?(TwizoError)

      response_to_array(response)
    end

    #
    # Delete de backup codes
    #
    # @return [Object]
    #
    def delete
      response = send_api_call(Entity::ACTION_REMOVE, "#{location}/#{@params.identifier}")

      raise response if response.kind_of?(TwizoError)

      # return 204 No Content
      response
    end

    private

    #
    # @return [String]
    #
    def location
      'backupcode'
    end

  end

end

