require_relative 'params'

module Twizo

  class VerificationParams < Params

    attr_accessor :recipient, :type, :token_length, :token_type, :body_template, :session_id, :sender, :sender_ton, :sender_npi, :tag, :validity, :dcs

    def to_json
      json = {
          :recipient          => recipient,
          :type               => type,
          :tokenLength        => token_length,
          :tokenType          => token_type,
          :bodyTemplate       => body_template,
          :sessionId          => session_id,
          :sender             => sender,
          :senderTon          => sender_ton,
          :senderNpi          => sender_npi,
          :tag                => tag,
          :validity           => validity,
          :dcs                => dcs
      }

      json.to_json
    end

  end

end