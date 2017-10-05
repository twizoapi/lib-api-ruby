require_relative 'examples_init'

=begin

 This file is part of the Twizo php api

 (c) Twizo <info@twizo.com>

 For the full copyright and license information, please view the LICENSE
 File that was distributed with this source code.

=end

twizo = Twizo::Twizo.new(API_KEY, API_HOST)

print 'Enter identifier: '
identifier = gets.chomp

begin

  check = twizo.get_backup_code(identifier)

rescue Twizo::TwizoError => e

  puts "#{e}: #{e.body}"

end

puts check.inspect