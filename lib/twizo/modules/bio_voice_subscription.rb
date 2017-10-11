require_relative 'params/bio_voice_params'

=begin

 This file is part of the Twizo php api

 (c) Twizo <info@twizo.com>

 For the full copyright and license information, please view the LICENSE
 File that was distributed with this source code.

=end

module Twizo

  module BioVoiceSubscription

    # Delete de bio voice registration
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
      'biovoice/subscription'
    end

  end

end