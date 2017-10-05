require_relative 'examples_init'

=begin

 This file is part of the Twizo php api

 (c) Twizo <info@twizo.com>

 For the full copyright and license information, please view the LICENSE
 File that was distributed with this source code.

=end

twizo = Twizo::Twizo.new(API_KEY, API_HOST)

print 'Enter number 1: '
number1 = gets.chomp

print 'Enter number 2: '
number2 = gets.chomp

sms = twizo.create_sms('test_message', [number1, number2], 'TestSender')
sms.params.result_type = Twizo::NumberLookup::RESULT_TYPE_POLL

begin

  sms = sms.send_simple

rescue Twizo::TwizoError => e

  puts "#{e}: #{e.body}"

end

puts sms.inspect