gem 'mocha'
require 'test/unit'
require 'mocha/test_unit'
require 'twizo'

=begin

 This file is part of the Twizo php api

 (c) Twizo <info@twizo.com>

 For the full copyright and license information, please view the LICENSE
 File that was distributed with this source code.

=end

class TestInit < Test::Unit::TestCase

  NUMBER1 = '601234567890'
  NUMBER2 = '311234567890'

  def self.load_config
    filename = 'credentials.rb'

    unless File.exist?("#{File.dirname(__FILE__)}/#{filename}")
      print 'Enter api key: '
      api_key = gets.chomp

      print 'Enter api host: '
      api_host = gets.chomp

      file = File.new("#{File.dirname(__FILE__)}/#{filename}", 'w')
      file.puts("API_KEY = '#{api_key}'")
      file.puts("API_HOST = '#{api_host}'")
      file.close
    end

    require_relative filename
  end

end

TestInit.load_config