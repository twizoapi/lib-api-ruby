=begin

 This file is part of the Twizo php api

 (c) Twizo <info@twizo.com>

 For the full copyright and license information, please view the LICENSE
 File that was distributed with this source code.

=end

module Twizo

  module Application

    # @return [Array]
    def types
      response = send_api_call(Entity::ACTION_RETRIEVE, 'application/verification_types')

      raise response if response.is_a?(TwizoError)

      # return array instead of json
      verification_types = []
      response.each_value { |type| verification_types << type }

      verification_types
    end

    # @return [Twizo::Result]
    def credentials
      response = send_api_call(Entity::ACTION_RETRIEVE, 'application/verifycredentials')

      raise response if response.is_a?(TwizoError)

      response_to_array(response)
    end

  end

end