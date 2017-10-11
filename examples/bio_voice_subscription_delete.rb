require_relative 'examples_init'

=begin

 This file is part of the Twizo php api

 (c) Twizo <info@twizo.com>

 For the full copyright and license information, please view the LICENSE
 File that was distributed with this source code.

=end

twizo = Twizo::Twizo.new(API_KEY, API_HOST)

print 'Enter recipient: '
recipient = gets.chomp

bio_voice_subscription = twizo.create_backup_codes(recipient)

begin

  bio_voice_subscription = bio_voice_subscription.delete

rescue Twizo::TwizoError => e

  puts "#{e}: #{e.body}"

end

puts 'success' if bio_voice_subscription.code == '204'