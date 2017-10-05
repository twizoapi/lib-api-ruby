require_relative 'examples_init'

=begin

 This file is part of the Twizo php api

 (c) Twizo <info@twizo.com>

 For the full copyright and license information, please view the LICENSE
 File that was distributed with this source code.

=end

twizo = Twizo::Twizo.new(API_KEY, API_HOST)

begin

  results = twizo.get_number_lookup_results

rescue Twizo::TwizoError => e

  puts "#{e}: #{e.body}"

end

puts 'no number lookup results found' unless results.result.length

puts results.inspect