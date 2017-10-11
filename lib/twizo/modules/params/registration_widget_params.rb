require_relative 'params'

module Twizo

    class RegistrationWidgetParams < Params

        attr_accessor :allowed_types, :recipient, :backup_code_identifier, :totp_identifier, :issuer

        # @return [Object]
        def to_json
            json = {
                :allowedTypes           => allowed_types,
                :recipient              => recipient,
                :backupCodeIdentifier   => backup_code_identifier,
                :totpIdentifier          => totp_identifier,
                :issuer                 => issuer
            }

            json.to_json
        end

    end
    
end