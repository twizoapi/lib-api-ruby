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

backup_code = twizo.create_backup_codes(identifier)

begin

  backup_code = backup_code.delete

rescue Twizo::TwizoError => e

  puts "#{e}: #{e.body}"

end

puts 'success' if backup_code.code == '204'