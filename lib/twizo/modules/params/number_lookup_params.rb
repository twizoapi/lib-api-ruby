require_relative 'params'

module Twizo

  class NumberLookupParams < Params

    attr_accessor :numbers, :tag, :validity, :result_type, :callback_url

    def to_json
      json = {
          :numbers         => format_to_array(numbers),
          :tag                => tag,
          :validity           => validity,
          :resultType         => result_type,
          :callbackUrl        => callback_url,
      }

      json.to_json
    end

  end

end