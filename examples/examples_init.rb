require 'json'

require 'twizo'

=begin

 Run examples from the comman line
 -> ruby foo.rb

 This file is part of the Twizo php api

 (c) Twizo <info@twizo.com>

 For the full copyright and license information, please view the LICENSE
 File that was distributed with this source code.

=end

class ExamplesInit

  def load_config
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

examples = ExamplesInit.new
examples.load_config