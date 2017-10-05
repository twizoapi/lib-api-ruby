require_relative 'params/number_lookup_params'

=begin

 This file is part of the Twizo php api

 (c) Twizo <info@twizo.com>

 For the full copyright and license information, please view the LICENSE
 File that was distributed with this source code.

=end

module Twizo

  module NumberLookup

    #
    # Getter for params
    #
    attr_reader :params

    #
    # Bitmasks of which type of result type to send
    #
    RESULT_TYPE_CALLBACK = 1
    RESULT_TYPE_POLL = 2

    #
    # @param [Array] numbers
    #
    def set(numbers)
      @params = NumberLookupParams.new
      @params.numbers = numbers
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

      response_to_array(response, 'items')
    end

    #
    # @return [Object]
    #
    def poll
      response = send_api_call(Entity::ACTION_RETRIEVE, 'numberlookup/poll')

      raise response if response.kind_of?(TwizoError)

      batch_id = response['batchId'] unless response['batchId'].nil?

      unless batch_id.nil?
        send_api_call(Entity::ACTION_REMOVE, 'numberlookup/poll/' + batch_id)
      end

      response_to_array(response, 'messages')
    end

    private

    #
    # @return [String]
    #
    def location
      'numberlookup/submit'
    end

  end

end

