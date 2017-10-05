require_relative 'params'

module Twizo

  class SmsParams < Params

    attr_accessor :recipients, :body, :sender, :sender_ton, :sender_npi, :pid, :scheduled_delivery, :tag, :validity, :result_type, :callback_url, :dcs, :udh

    def to_json(send_advanced = nil)
      json = {
          :recipients         => format_to_array(recipients),
          :body               => body,
          :sender             => sender,
          :senderTon          => sender_ton,
          :senderNpi          => sender_npi,
          :pid                => pid,
          :scheduledDelivery  => scheduled_delivery,
          :tag                => tag,
          :validity           => validity,
          :resultType         => result_type,
          :callbackUrl        => callback_url,
      }

      if send_advanced
        json[:dcs] = dcs
        json[:udh] = udh
      end

      json.to_json
    end

  end

end