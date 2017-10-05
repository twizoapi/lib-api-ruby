require_relative 'examples_init'

=begin

 This file is part of the Twizo php api

 (c) Twizo <info@twizo.com>

 For the full copyright and license information, please view the LICENSE
 File that was distributed with this source code.

=end

twizo = Twizo::Twizo.new(API_KEY, API_HOST)

print 'Enter number: '
number = gets.chomp

widget = twizo.create_widget(number)

begin

  print 'Enter session token: '
  sessionToken = gets.chomp

  status = twizo.get_widget_status(sessionToken, number)

rescue Twizo::TwizoError => e

  puts "#{e}: #{e.body}"

end

puts status.inspect