require_relative 'params/registration_widget_params'

=begin
 This file is part of the Twizo Ruby api

 (c) Twizo <info@twizo.com>

 For the full copyright and license information, please view the LICENSE
 File that was distributed with this source code.
 
=end 

module Twizo

  module RegistrationWidget
    
    TYPE_CALL               = 'call'.freeze
    TYPE_SMS                = 'sms'.freeze
    TYPE_PUSH               = 'push'.freeze
    TYPE_BIO_VOICE          = 'biovoice'.freeze
    TYPE_TELEGRAM           = 'telegram'.freeze
    TYPE_LINE               = 'line'.freeze
    TYPE_TOTP               = 'totp'.freeze
    TYPE_BACKUPCODE         = 'backupcode'.freeze

    # Getter for params
    attr_reader :params

    def set(recipient)
      @params = RegistrationWidgetParams.new
      @params.recipient = recipient
    end

    # Send message to the server and return response
    # @return [Result]
    def send
      post_params = @params.to_json
      response = send_api_call(Entity::ACTION_CREATE, location, post_params)

      raise response if response.is_a?(TwizoError)

      response_to_array(response)
    end

    private

    # @return [String]
    def location
      'widget-register-verification/session'
    end

  end

end

