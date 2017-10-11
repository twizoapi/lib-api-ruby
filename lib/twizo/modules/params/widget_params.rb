require_relative 'params'

module Twizo

  class WidgetParams < Params

    attr_accessor :allowed_types, :recipient, :backup_code_identifier, :token_length, :token_type, :body_template, :sender, :sender_ton, :sender_npi, :tag, :dcs

    # @return [Object]
    def to_json
      json = {
          :allowedTypes           => allowed_types,
          :recipient              => recipient,
          :backupCodeIdentifier   => backup_code_identifier,
          :tokenLength            => token_length,
          :tokenType              => token_type,
          :bodyTemplate           => body_template,
          :sender                 => sender,
          :senderTon              => sender_ton,
          :senderNpi              => sender_npi,
          :tag                    => tag,
          :dcs                    => dcs
      }

      json.to_json
    end

  end

end