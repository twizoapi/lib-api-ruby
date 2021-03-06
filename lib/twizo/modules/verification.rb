require_relative 'params/verification_params'

=begin

 This file is part of the Twizo php api

 (c) Twizo <info@twizo.com>

 For the full copyright and license information, please view the LICENSE
 File that was distributed with this source code.

=end

module Twizo

  module Verification

    TYPE_CALL               = 'call'.freeze
    TYPE_SMS                = 'sms'.freeze
    TYPE_PUSH               = 'push'.freeze
    TYPE_BIO_VOICE          = 'biovoice'.freeze
    TYPE_TELEGRAM           = 'telegram'.freeze
    TYPE_LINE               = 'line'.freeze
    TYPE_FACEBOOK_MESSENGER = 'facebook_messenger'.freeze

    # Getter for params
    attr_reader :params

    # @param [String] recipient
    def set(recipient)
      @params = VerificationParams.new
      @params.recipient = recipient
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
    # @return [Twizo::Result]
    def verify(message_id, token)
      response = send_api_call(Entity::ACTION_RETRIEVE, "#{location}/#{message_id}?token=#{token}")

      raise response if response.is_a?(TwizoError)

      response_to_array(response)
    end

    private

    # @return [String]
    def location
      'verification/submit'
    end

  end

end