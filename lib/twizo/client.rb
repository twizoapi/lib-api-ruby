=begin

 This file is part of the Twizo php api

 (c) Twizo <info@twizo.com>

 For the full copyright and license information, please view the LICENSE
 File that was distributed with this source code.

=end

module Twizo

  class Client

    API_VERSION = 'v1'
    API_USERNAME = 'twizo'
    LIB_NAME = 'Twizo-ruby-lib'
    LIB_VERSION = '0.1.0'

    #
    # Constructor
    #
    # @param [String] api_key
    # @param [String] api_host
    #
    def initialize(api_key, api_host)
      @api_key, @api_host = api_key, api_host
    end

    #
    # @return [String]
    #
    def user_agent
      sprintf('%s/%s Ruby/%s/%s',
              LIB_NAME,
              LIB_VERSION,
              RUBY_VERSION,
              RUBY_PLATFORM
      )
    end

  end

end