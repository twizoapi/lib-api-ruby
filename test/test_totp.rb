require_relative 'test_init'

=begin

 This file is part of the Twizo php api

 (c) Twizo <info@twizo.com>

 For the full copyright and license information, please view the LICENSE
 File that was distributed with this source code.

=end

class TestTotp < TestInit

  # Initialize Twizo
  def setup
    @twizo = Twizo::Twizo.new(API_KEY, API_HOST)
  end

  # Test creation of totp
  def test_create_totp
    test_number = rand(11111111..999999999).to_s

    totp = @twizo.create_totp(nil, 'Twizo')
    totp.params.identifier = test_number

    totp = totp.send

    assert_equal test_number, totp.identifier
  end

  # Test status of totp
  def test_totp_status
    test_number = rand(11111111..999999999).to_s

    totp = @twizo.create_totp(nil, 'Twizo')
    totp.params.identifier = test_number

    totp = totp.send

    identifier = totp.identifier

    status = @twizo.get_totp_status(identifier)

    assert_equal identifier, status.identifier
  end

  # Test status of bio voice
  def test_totp_no_identifier

    totp = @twizo.create_totp(nil, 'Twizo')

    assert_raise Twizo::TwizoError do
      totp = totp.send
    end
  end

  # Test status of bio voice
  def test_totp_no_issuer

    totp = @twizo.create_totp('123490783', nil)

    assert_raise Twizo::TwizoError do
      totp = totp.send
    end
  end

  def teardown
    print "\n#{method_name}"
  end

end