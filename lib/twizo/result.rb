=begin

 This file is part of the Twizo php api

 (c) Twizo <info@twizo.com>

 For the full copyright and license information, please view the LICENSE
 File that was distributed with this source code.

=end

module Twizo

  class Result

    attr_reader :result

    # Constructor
    # @param [Array] result
    def initialize(result)
      set_fields(result)
    end

    # @param [Array] fields
    def set_fields(fields)
      fields.each do |name, value|
        add_attribute_accessor(name, value)
      end
    end

    # Getter and Setter fields are dynamically created
    # @param [String] attr_name
    # @param [Object] attr_value
    def add_attribute_accessor(attr_name, attr_value)
      self.class.send(:define_method, "#{attr_name}=".to_sym) do |value|
        instance_variable_set('@' + attr_name.to_s, value)
      end

      self.class.send(:define_method, attr_name.to_sym) do
        instance_variable_get('@' + attr_name.to_s)
      end

      self.send("#{attr_name}=".to_sym, attr_value)
    end

    # add an item to parent result
    # @param [Object] item
    def add_result(item)
      @result ||= []
      @result << item
    end

  end

end