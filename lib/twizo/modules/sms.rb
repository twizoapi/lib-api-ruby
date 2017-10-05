require_relative 'params/sms_params'

=begin

 This file is part of the Twizo php api

 (c) Twizo <info@twizo.com>

 For the full copyright and license information, please view the LICENSE
 File that was distributed with this source code.

=end

module Twizo

  module Sms

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
    # @param [String] body
    # @param [Array] recipients
    # @param [String] sender
    #
    def set(body, recipients, sender)
      @params = SmsParams.new
      @params.body = body
      @params.recipients = recipients
      @params.sender = sender
    end

    #
    # Send message to the server and return response
    #
    # @return [Object]
    #
    def send_simple
      post_params = @params.to_json

      response = send_api_call(Entity::ACTION_CREATE, 'sms/submitsimple', post_params)

      raise response if response.kind_of?(TwizoError)

      response_to_array(response, 'items')
    end

    #
    # Send message to the server and return response
    #
    # @return [Object]
    #
    def send
      # set @dcs to 0 if dcs is not set
      @params.dcs ||= 0

      @params.body = bin_to_hex(@params.body).upcase if is_binary?

      post_params = @params.to_json send_advanced: true

      response = send_api_call(Entity::ACTION_CREATE, location, post_params)

      raise response if response.kind_of?(TwizoError)

      response_to_array(response, 'items')
    end

    #
    # @return [Object]
    #
    def poll

      response = send_api_call(Entity::ACTION_RETRIEVE, 'sms/poll')

      raise response if response.kind_of?(TwizoError)

      @batch_id = response['batchId'] unless response['batchId'].nil?

      unless @batch_id == ''
        send_api_call(Entity::ACTION_REMOVE, 'sms/poll/' + @batch_id)
      end

      response_to_array(response, 'messages')
    end

    private

    #
    # @return [String]
    #
    def location
      'sms/submit'
    end

    #
    # @return [Boolean]
    #
    def is_binary?
      binary = false

      if (@params.dcs & 200) === 0
        binary = ((@params.dcs & 4) > 0)
      elsif (@params.dcs & 4) > 0
        binary = ((@params.dcs & 4) > 0)
      end

      binary
    end

    #
    # @param [Binary] binary_string
    #
    # @return [Hex]
    #
    def bin_to_hex(binary_string)
      binary_string.unpack('H*').first
    end

  end

end

