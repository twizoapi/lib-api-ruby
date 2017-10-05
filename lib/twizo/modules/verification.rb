require_relative 'params/verification_params'

=begin

 This file is part of the Twizo php api

 (c) Twizo <info@twizo.com>

 For the full copyright and license information, please view the LICENSE
 File that was distributed with this source code.
 
=end

module Twizo

  module Verification

    #
    # Getter for params
    #
    attr_reader :params

    #
    # @param [String] recipient
    #
    def set(recipient)
      @params = VerificationParams.new
      @params.recipient = recipient

      # set default type
      @params.type ||= 'sms'
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
    # @param [String] token
    #
    # @return [Object]
    #
    def verify(message_id, token)
      response = send_api_call(Entity::ACTION_RETRIEVE, "#{location}/#{message_id}?token=#{token}")

      raise response if response.kind_of?(TwizoError)

      response_to_array(response)
    end

    private

    #
    # @return [String]
    #
    def location
      'verification/submit'
    end

  end

end