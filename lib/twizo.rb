require "twizo/version"
require "twizo/client/net_http_client"
require "twizo/entity"
require "twizo/status_codes"

require "twizo/modules/number_lookup"
require "twizo/modules/sms"
require "twizo/modules/balance"
require "twizo/modules/backup_codes"
require "twizo/modules/verification"
require "twizo/modules/widget"

=begin

 This file is part of the Twizo php api

 (c) Twizo <info@twizo.com>

 For the full copyright and license information, please view the LICENSE
 File that was distributed with this source code.

=end

module Twizo

  class Twizo

    #
    # Constructor
    #
    # @param [String] api_key
    # @param [String] api_host
    #
    def initialize(api_key, api_host)
      @client = NetHttpClient.new(api_key, api_host)
    end

    # Number Lookup

    #
    # @param [String|Array] numbers
    #
    def create_number_lookup(numbers)
      number_lookup = Entity.new(@client).extend(NumberLookup)
      number_lookup.set(numbers)
      number_lookup
    end

    #
    # @param [String] message_id
    #
    # @return [Object]
    #
    def get_number_lookup_status(message_id)
      number_lookup = Entity.new(@client).extend(NumberLookup)
      number_lookup.populate(message_id)
    end

    #
    # @return [Object]
    #
    def get_number_lookup_results
      number_lookup = Entity.new(@client).extend(NumberLookup)
      number_lookup.poll
    end

    # Sms

    #
    # @param [String] body
    # @param [String|Array] recipients
    # @param [String] sender
    #
    # @return [Object]
    #
    def create_sms(body, recipients, sender)
      sms = Entity.new(@client).extend(Sms)
      sms.set(body, recipients, sender)
      sms
    end

    #
    # @param [String] message_id
    #
    # @return [Object]
    #
    def get_sms_status(message_id)
      sms = Entity.new(@client).extend(Sms)
      sms.populate(message_id)
    end

    #
    # @return [Object]
    #
    def get_sms_results
      sms = Entity.new(@client).extend(Sms)
      sms.poll
    end

    # Balance

    def get_balance
      balance = Entity.new(@client).extend(Balance)
      balance.send
    end

    # Backup Codes

    #
    # @param [String] identifier
    #
    # @return [Object]
    #
    def create_backup_codes(identifier)
      backup_codes = Entity.new(@client).extend(BackupCodes)
      backup_codes.set(identifier)
      backup_codes
    end

    #
    # @param [String] identifier
    #
    # @return [Object]
    #
    def get_backup_code(identifier)
      backup_codes = Entity.new(@client).extend(BackupCodes)
      backup_codes.populate(identifier)
    end

    # Verification

    #
    # @param [String] recipient
    #
    # @return [Object]
    #
    def create_verification(recipient)
      verification = Entity.new(@client).extend(Verification)
      verification.set(recipient)
      verification
    end

    #
    # @param [String] message_id
    # @param [String] token
    #
    # @return [Object]
    #
    def verify_token(message_id, token)
      verification = Entity.new(@client).extend(Verification)
      verification.verify(message_id, token)
    end

    #
    # @param [String] message_id
    #
    # @return [Object]
    #
    def get_verification_status(message_id)
      verification = Entity.new(@client).extend(Verification)
      verification.populate(message_id)
    end

    # Verification widget

    #
    # @param [String] recipient
    #
    # @return [Object]
    #
    def create_widget(recipient)
      widget = Entity.new(@client).extend(Widget)
      widget.set(recipient)
      widget
    end

    #
    # @param [String] session_token
    # @param [String|null] recipient
    # @param [String|null] backup_code_identifier
    #
    # @return [Object]
    #
    def get_widget_status(session_token, recipient = nil, backup_code_identifier = nil)
      widget = Entity.new(@client).extend(Widget)
      widget.populate(session_token, recipient, backup_code_identifier)
    end

  end
end
