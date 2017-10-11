require_relative 'test_init'

=begin

 This file is part of the Twizo php api

 (c) Twizo <info@twizo.com>

 For the full copyright and license information, please view the LICENSE
 File that was distributed with this source code.

=end

class TestApplication < TestInit

  # Initialize Twizo
  def setup
    client = Twizo::NetHttpClient.new(API_KEY, API_HOST)
    @entity = Twizo::Entity.new(client).extend(Twizo::Application)
  end

  # Test retrieving of the verification types
  def test_get_verification_types
    return_values = JSON.parse('{"0":"sms","1":"call","2":"biovoice"}')
    @entity.stubs(:send_api_call).returns(return_values)

    verification_types = @entity.types
    assert_true verification_types.is_a?(Array)
    assert_equal ['sms', 'call', 'biovoice'], verification_types
  end

  # Test retrieving of the verification types
  def test_get_verification_types_error
    return_values = Twizo::TwizoError.new(401, 'Error')
    @entity.stubs(:send_api_call).returns(return_values)

    assert_raise Twizo::TwizoError do
      @entity.types
    end
  end

  # Test retrieving verification of credentials
  def test_verify_credentials
    return_values = JSON.parse('{"applicationTag":"Test application", "isTestKey":"true"}')
    @entity.stubs(:send_api_call).returns(return_values)

    credentials = @entity.credentials
    assert_true credentials.is_a?(Twizo::Result)
    assert_equal 'Test application', credentials.applicationTag
    assert_equal 'true', credentials.isTestKey
  end

  def teardown
    print "\n#{method_name}"
  end

end