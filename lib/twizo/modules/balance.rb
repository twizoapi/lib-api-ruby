=begin

 This file is part of the Twizo php api

 (c) Twizo <info@twizo.com>

 For the full copyright and license information, please view the LICENSE
 File that was distributed with this source code.

=end

module Twizo

  module Balance

    #
    # Send message to the server and return response
    #
    # @return [Object]
    #
    def send
      response = send_api_call(Entity::ACTION_RETRIEVE, location)

      raise response if response.kind_of?(TwizoError)

      response_to_array(response)
    end

    private

    #
    # @return [String]
    #
    def location
      'wallet/getbalance'
    end

  end

end