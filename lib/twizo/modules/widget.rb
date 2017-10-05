require_relative 'params/widget_params'

=begin

 This file is part of the Twizo php api

 (c) Twizo <info@twizo.com>

 For the full copyright and license information, please view the LICENSE
 File that was distributed with this source code.
 
=end

module Twizo

  module Widget

    #
    # Getter for params
    #
    attr_reader :params

    #
    # @param [String] recipient
    #
    def set(recipient)
      @params = WidgetParams.new
      @params.recipient = recipient

      # set default allowed_types
      @params.allowed_types ||= %w(sms call)
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

    private

    #
    # @return [String]
    #
    def location
      'widget/session'
    end

  end

end