require_relative 'params/totp_params'

=begin

 This file is part of the Twizo php api

 (c) Twizo <info@twizo.com>

 For the full copyright and license information, please view the LICENSE
 File that was distributed with this source code.

=end

module Twizo

  module Totp

    # Getter for params
    attr_reader :params

    # @param [String] identifier
    # @param [String] issuer
    def set(identifier, issuer)
      @params = TotpParams.new
      @params.identifier = identifier
      @params.issuer = issuer
    end

    # Send message to the server and return response
    # @return [Twizo::Result]
    def send
      post_params = @params.to_json

      response = send_api_call(Entity::ACTION_CREATE, location, post_params)

      raise response if response.is_a?(TwizoError)

      response_to_array(response)
    end

    # @param [String] token
    # @return [Result]
    def verify(token)
      response = send_api_call(Entity::ACTION_RETRIEVE, "#{location}/#{@params.identifier}?token=#{token}")

      raise response if response.is_a?(TwizoError)

      response_to_array(response)
    end

    # Delete de totp
    # @return [Net::HTTPNoContent]
    def delete
      response = send_api_call(Entity::ACTION_REMOVE, "#{location}/#{@params.identifier}")

      raise response if response.is_a?(TwizoError)

      # return 204 No Content
      response
    end

    private

    # @return [String]
    def location
      'totp'
    end

  end

end