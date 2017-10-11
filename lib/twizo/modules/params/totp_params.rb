require_relative 'params'

module Twizo

  class TotpParams < Params

    attr_accessor :identifier, :issuer

    # @return [Object]
    def to_json
      json = {
          :identifier => identifier,
          :issuer     => issuer,
      }

      json.to_json
    end

  end

end