require_relative 'params/bio_voice_params'

=begin

 This file is part of the Twizo php api

 (c) Twizo <info@twizo.com>

 For the full copyright and license information, please view the LICENSE
 File that was distributed with this source code.

=end

module Twizo

  module BioVoiceRegistration

    # Getter for params
    attr_reader :params

    # @param [String] recipient
    # @param [String] language
    # @param [String] web_hook
    def set(recipient, language = nil, web_hook = nil)
      @params = BioVoiceParams.new
      @params.recipient = recipient
      @params.language = language
      @params.web_hook = web_hook
    end

    # Send message to the server and return response
    # @return [Twizo::Result]
    def send
      post_params = @params.to_json

      response = send_api_call(Entity::ACTION_CREATE, location, post_params)

      raise response if response.is_a?(TwizoError)

      response_to_array(response)
    end

    private

    # @return [String]
    def location
      'biovoice/registration'
    end

  end

end