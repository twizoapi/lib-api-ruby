require_relative 'examples_init'

=begin

 This file is part of the Twizo php api

 (c) Twizo <info@twizo.com>

 For the full copyright and license information, please view the LICENSE
 File that was distributed with this source code.

=end

twizo = Twizo::Twizo.new(API_KEY, API_HOST)

begin

  verification_types = twizo.get_verification_types

rescue Twizo::TwizoError => e

  puts "#{e}: #{e.body}"

end

puts verification_types.inspect