require_relative 'params'

module Twizo

  class BackupCodesParams < Params

    attr_accessor :identifier

    def to_json
      json = {
          :identifier => identifier
      }

      json.to_json
    end

  end

end