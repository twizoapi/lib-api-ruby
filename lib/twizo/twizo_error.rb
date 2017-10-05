=begin

 This file is part of the Twizo php api

 (c) Twizo <info@twizo.com>

 For the full copyright and license information, please view the LICENSE
 File that was distributed with this source code.

=end

module Twizo

  class TwizoError < StandardError

    attr_reader :body

    def initialize(code, body = nil?)
      super(code)

      @body = body
    end

  end

end