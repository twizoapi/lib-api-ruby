require_relative 'examples_init'

=begin

 This file is part of the Twizo php api

 (c) Twizo <info@twizo.com>

 For the full copyright and license information, please view the LICENSE
 File that was distributed with this source code.

=end

twizo = Twizo::Twizo.new(API_KEY, API_HOST)

print 'Enter number (enter: 12300000 for testing): '
number = gets.chomp

begin

  verification = twizo.create_verification(number)

  puts 'messageId = ' + verification.send.messageId

  print 'Enter message id: '
  message_id = gets.chomp

  print 'Enter token (enter: 012345 for testing): '
  token = gets.chomp

  verify_token = twizo.verify_token(message_id, token)

rescue Twizo::TwizoError => e

  puts "#{e}: #{e.body}"

end

puts verify_token.inspect