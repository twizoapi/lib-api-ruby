require_relative 'params'

module Twizo

  class BioVoiceParams < Params

    attr_accessor :recipient, :language, :web_hook

    # @return [Object]
    def to_json
      json = {
          :recipient  => recipient,
          :language   => language,
          :webHook    => web_hook,
      }

      json.to_json
    end

  end

end