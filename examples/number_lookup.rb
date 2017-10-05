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

number_lookup = twizo.create_number_lookup(number)
number_lookup.params.result_type = Twizo::NumberLookup::RESULT_TYPE_POLL

begin

  number_lookup = number_lookup.send

rescue Twizo::TwizoError => e

  puts "#{e}: #{e.body}"

end

puts number_lookup.inspect