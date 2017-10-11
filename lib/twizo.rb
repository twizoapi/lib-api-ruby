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
require "twizo/modules/application"
require "twizo/modules/bio_voice_registration"
require "twizo/modules/bio_voice_subscription"
require "twizo/modules/totp"
require "twizo/modules/registration_widget"

=begin

 This file is part of the Twizo php api

 (c) Twizo <info@twizo.com>

 For the full copyright and license information, please view the LICENSE
 File that was distributed with this source code.

=end

module Twizo

  class Twizo

    # Constructor
    # @param [String] api_key
    # @param [String] api_host
    def initialize(api_key, api_host)
      @client = NetHttpClient.new(api_key, api_host)
    end

    # Number Lookup

    # @param [String|Array] numbers
    # @return [Twizo::Entity]
    def create_number_lookup(numbers)
      number_lookup = Entity.new(@client).extend(NumberLookup)
      number_lookup.set(numbers)
      number_lookup
    end

    # @param [String] message_id
    # @return [Twizo::Result]
    def get_number_lookup_status(message_id)
      number_lookup = Entity.new(@client).extend(NumberLookup)
      number_lookup.populate(message_id)
    end

    # @return [Twizo::Result]
    def get_number_lookup_results
      number_lookup = Entity.new(@client).extend(NumberLookup)
      number_lookup.poll
    end

    # Sms

    # @param [String] body
    # @param [String|Array] recipients
    # @param [String] sender
    # @return [Twizo::Entity]
    def create_sms(body, recipients, sender)
      sms = Entity.new(@client).extend(Sms)
      sms.set(body, recipients, sender)
      sms
    end

    # @param [String] message_id
    # @return [Twizo::Result]
    def get_sms_status(message_id)
      sms = Entity.new(@client).extend(Sms)
      sms.populate(message_id)
    end

    # @return [Twizo::Result]
    def get_sms_results
      sms = Entity.new(@client).extend(Sms)
      sms.poll
    end

    # Balance

    # @return [Twizo::Result]
    def get_balance
      balance = Entity.new(@client).extend(Balance)
      balance.send
    end

    # Backup Codes

    # @param [String] identifier
    # @return [Twizo::Entity]
    def create_backup_codes(identifier)
      backup_codes = Entity.new(@client).extend(BackupCodes)
      backup_codes.set(identifier)
      backup_codes
    end

    # @param [String] identifier
    # @return [Twizo::Result]
    def get_backup_code(identifier)
      backup_codes = Entity.new(@client).extend(BackupCodes)
      backup_codes.populate(identifier)
    end

    # Verification

    # @param [String] recipient
    # @return [Twizo::Entity]
    def create_verification(recipient)
      verification = Entity.new(@client).extend(Verification)
      verification.set(recipient)
      verification
    end

    # @param [String] message_id
    # @param [String] token
    # @return [Twizo::Result]
    def verify_token(message_id, token)
      verification = Entity.new(@client).extend(Verification)
      verification.verify(message_id, token)
    end

    # @param [String] message_id
    # @return [Twizo::Result]
    def get_verification_status(message_id)
      verification = Entity.new(@client).extend(Verification)
      verification.populate(message_id)
    end

    # Verification widget

    # @param [String] recipient
    # @return [Twizo::Entity]
    def create_widget(recipient)
      widget = Entity.new(@client).extend(Widget)
      widget.set(recipient)
      widget
    end

    # @param [String] session_token
    # @param [String|null] recipient
    # @param [String|null] backup_code_identifier
    # @return [Twizo::Result]
    def get_widget_status(session_token, recipient = nil, backup_code_identifier = nil)
      widget = Entity.new(@client).extend(Widget)
      widget.populate(session_token, recipient, backup_code_identifier)
    end

    # Application

    # @return [Twizo::Result]
    def get_verification_types
      application = Entity.new(@client).extend(Application)
      application.types
    end

    # @return [Twizo::Result]
    def verify_credentials
      application = Entity.new(@client).extend(Application)
      application.credentials
    end

    # Bio Voice

    # @param [Object] recipient
    # @param [Object] language
    # @param [Object] web_hook
    # @return [Twizo::Entity]
    def create_bio_voice_registration(recipient, language = nil, web_hook = nil)
      bio_voice = Entity.new(@client).extend(BioVoiceRegistration)
      bio_voice.set(recipient, language, web_hook)
      bio_voice
    end

    # @param [String] registration_id
    # @return [Twizo::Result]
    def get_bio_voice_registration_status(registration_id)
      bio_voice = Entity.new(@client).extend(BioVoiceRegistration)
      bio_voice.populate(registration_id)
    end

    # @param [String] recipient
    # @return [Twizo::Result]
    def get_bio_voice_subscription(recipient)
      bio_voice = Entity.new(@client).extend(BioVoiceSubscription)
      bio_voice.populate(recipient)
    end

    # Totp

    def create_totp(identifier, issuer)
      totp = Entity.new(@client).extend(Totp)
      totp.set(identifier, issuer)
      totp
    end

    # @param [String] identifier
    # @return [Twizo::Result]
    def get_totp_status(identifier)
      totp = Entity.new(@client).extend(Totp)
      totp.populate(identifier)
    end

    # Registration widget

    # @param [String] recipient
    # @return [Twizo::Entity]
    def create_registration_widget(recipient)
      registration_widget = Entity.new(@client).extend(RegistrationWidget)
      registration_widget.set(recipient)
      registration_widget
    end

  end
end
