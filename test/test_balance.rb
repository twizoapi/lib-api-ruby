require_relative 'test_init'

=begin

 This file is part of the Twizo php api

 (c) Twizo <info@twizo.com>

 For the full copyright and license information, please view the LICENSE
 File that was distributed with this source code.

=end

class TestBalance < TestInit

  #
  # Initialize Twizo
  #
  def setup
    @twizo = Twizo::Twizo.new(API_KEY, API_HOST)
  end

  #
  # Test if an error is thrown when an invalid key is provided
  #
  def test_invalid_key
    api_key = 'invalid_key'

    assert_raise Twizo::TwizoError do
      @twizo = Twizo::Twizo.new(api_key, API_HOST)
      @twizo.get_balance
    end
  end

  #
  # Test get balance
  #
  def test_get_balance
    balance = @twizo.get_balance

    assert_not_nil balance.credit
    assert_not_nil balance.currencyCode
    assert_not_nil balance.freeVerifications
    assert_not_nil balance.wallet
  end

  def teardown
    print "\n#{method_name}"
  end

end