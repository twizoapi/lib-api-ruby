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

# example setting the recipient
bio_voice = twizo.create_bio_voice_registration('')
bio_voice.params.recipient = recipient

begin

  bio_voice = bio_voice.send

rescue Twizo::TwizoError => e

  puts "#{e}: #{e.body}"

end

puts bio_voice.inspect