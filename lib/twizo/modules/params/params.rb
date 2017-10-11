require 'json'

module Twizo

  class Params

    # @param [String|Array] attributes
    # @return [Array]
    def format_to_array(attributes)
      attributes_array = attributes.is_a?(Array) ? attributes : [attributes]
      attributes.nil? ? attributes : format_input(attributes_array)
    end

    # @param [Array] attributes
    # @return [Array]
    def format_input(attributes)
      attributes.map do |attribute|
        attribute.gsub!(/[()+o ]/, '()+ ' => '', 'o' => '0')
        attribute.gsub!(/^0+/, '')
        unless attribute.scan(/\D/).empty?
          raise TwizoError.new(422, 'The number(s) may not contain any characters.')
        end
      end

      attributes
    end

  end

end