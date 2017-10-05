require_relative 'test_init'

=begin

 This file is part of the Twizo php api

 (c) Twizo <info@twizo.com>

 For the full copyright and license information, please view the LICENSE
 File that was distributed with this source code.

=end

class TestVerification < TestInit

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
      verification = @twizo.create_verification(NUMBER1)
      verification.send
    end
  end

  #
  # Test creation of verification
  #
  def test_create_verification
    verification = @twizo.create_verification(nil)

    test_recipient = NUMBER1

    verification.params.recipient = test_recipient

    verification = verification.send

    assert_equal test_recipient, verification.recipient
    assert_not_nil verification.messageId
  end

  #
  # Test token verification
  #
  def test_verify_token
    test_recipient = '5412300000'

    verification = @twizo.create_verification(nil)
    verification.params.recipient = test_recipient

    verification = verification.send

    test_message_id = verification.messageId
    test_token = '012345'

    verify_token = @twizo.verify_token(test_message_id, test_token)

    assert_equal test_message_id, verify_token.messageId
    assert_equal test_recipient, verify_token.recipient
  end

  #
  # Test creation of verification and get status
  #
  def test_get_verification_status
    test_recipient = NUMBER1

    verification = @twizo.create_verification(test_recipient)
    verification = verification.send

    test_message_id = verification.messageId

    status = @twizo.get_verification_status(test_message_id)

    assert_equal test_message_id, status.messageId
    assert_equal test_recipient, status.recipient
  end

  #
  # Test creation of an invalid verification
  #
  def test_get_verification_status_invalid
    test_recipient = 'number'

    verification = @twizo.create_verification(test_recipient)

    assert_raise Twizo::TwizoError do
      verification = verification.send
    end
  end

  def teardown
    print "\n#{method_name}"
  end

end