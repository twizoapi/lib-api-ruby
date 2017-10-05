require_relative 'test_init'

=begin

 This file is part of the Twizo php api

 (c) Twizo <info@twizo.com>

 For the full copyright and license information, please view the LICENSE
 File that was distributed with this source code.

=end

class TestSms < TestInit

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
      sms = @twizo.create_sms('test body', NUMBER1, 'test sender')
      sms.send_simple
    end
  end

  #
  # Test creation of sms with multiple numbers
  #
  def test_create_sms
    sms = @twizo.create_sms(nil, nil, nil)

    test_recipients = [NUMBER1, NUMBER2]
    test_body = 'test body'
    test_sender = 'test sender'
    test_sender_ton = 5
    test_sender_npi = 0
    test_pid = 0
    test_scheduled_delivery = nil
    test_tag = 'test tag'
    test_validity = 259200
    test_result_type = 0
    test_callback_url = nil

    sms.params.recipients = test_recipients
    sms.params.body = test_body
    sms.params.sender = test_sender
    sms.params.sender_ton = test_sender_ton
    sms.params.sender_npi = test_sender_npi
    sms.params.pid = test_pid
    sms.params.scheduled_delivery = test_scheduled_delivery
    sms.params.tag = test_tag
    sms.params.validity = test_validity
    sms.params.result_type = test_result_type
    sms.params.callback_url = test_callback_url

    sms = sms.send_simple

    assert_equal test_recipients[0], sms.result[0].recipient
    assert_equal test_tag, sms.result[0].tag
    assert_equal 'no status', sms.result[0].status

    assert_equal test_recipients[1], sms.result[1].recipient
    assert_equal test_tag, sms.result[1].tag
    assert_equal 'no status', sms.result[1].status
  end

  #
  # Test creation of sms with a single number
  #
  def test_create_sms_single
    sms = @twizo.create_sms('test body', nil, 'test sender')

    test_recipient = NUMBER1
    sms.params.recipients = test_recipient

    sms = sms.send_simple

    test_message_id = sms.result[0].messageId

    status = @twizo.get_sms_status(test_message_id)

    assert_equal test_message_id, status.messageId
    assert_equal test_recipient, status.recipient
  end

  #
  # Test creation of sms advanced with a single number
  #
  def test_create_sms_advanced
    sms = @twizo.create_sms('Body',  nil, 'test sender')

    test_recipient = '60178467034'
    sms.params.recipients = test_recipient
    sms.params.dcs = 4

    sms = sms.send

    test_message_id = sms.result[0].messageId

    status = @twizo.get_sms_status(test_message_id)

    assert_equal test_message_id, status.messageId
    assert_equal test_recipient, status.recipient
  end

  #
  # Test creation of simple sms
  #
  def test_create_sms_simple
    sms = @twizo.create_sms('test body', nil, 'test sender')

    test_recipient = NUMBER1
    sms.params.recipients = test_recipient

    sms = sms.send_simple

    test_message_id = sms.result[0].messageId

    status = @twizo.get_sms_status(test_message_id)

    assert_equal test_message_id, status.messageId
    assert_equal test_recipient, status.recipient
  end

  #
  # Test creation of sms and get status
  #
  def test_get_sms_status
    test_recipient = NUMBER1

    sms = @twizo.create_sms('test body', test_recipient, 'test sender')
    sms = sms.send_simple

    test_message_id = sms.result[0].messageId

    status = @twizo.get_sms_status(test_message_id)

    assert_equal test_message_id, status.messageId
    assert_equal test_recipient, status.recipient
  end

  #
  # Test creation of sms and get results after completion of status
  #
  def test_get_sms_results
    test_recipient = NUMBER1

    sms = @twizo.create_sms('test body', test_recipient, 'test sender')
    sms.params.result_type = 2
    sms = sms.send_simple

    x = false
    until x
      if @twizo.get_sms_status(sms.result[0].messageId).status == 'no status'
        sleep 0.5
        next
      end
      x = true
    end

    results = @twizo.get_sms_results

    assert_not_nil results.batchId

    results.result.each do |item|
      assert_not_nil item.recipient
      assert_not_nil item.messageId
    end
  end

  #
  # Test number input normal
  #
  def test_different_recipients1
    test_recipients = '1234567890'
    sms = @twizo.create_sms('test body', test_recipients, 'test sender')

    sms = sms.send_simple

    assert_equal '1234567890', sms.result[0].recipient
  end

  #
  # Test number input with +
  #
  def test_different_recipients2
    test_recipients = '+1234567890'
    sms = @twizo.create_sms('test body', test_recipients, 'test sender')

    sms = sms.send_simple

    assert_equal '1234567890', sms.result[0].recipient
  end

  #
  # Test number input with 00
  #
  def test_different_recipients3
    test_recipients = '0000001234567890'
    sms = @twizo.create_sms('test body', test_recipients, 'test sender')

    sms = sms.send_simple

    assert_equal '1234567890', sms.result[0].recipient
  end

  #
  # Test number input with ' '
  #
  def test_different_recipients4
    test_recipients = '1 23 45 67 89 0'
    sms = @twizo.create_sms('test body', test_recipients, 'test sender')

    sms = sms.send_simple

    assert_equal '1234567890', sms.result[0].recipient
  end

  #
  # Test number input with Characters
  #
  def test_different_recipients5
    test_recipients = '1 23 A5 67 89 o'

    assert_raise Twizo::TwizoError do
      sms = @twizo.create_sms('test body', test_recipients, 'test sender')

      sms.send_simple
    end
  end

  #
  # Test number input with ()
  #
  def test_different_recipients6
    test_recipients = '(1)234567890'
    sms = @twizo.create_sms('test body', test_recipients, 'test sender')

    sms = sms.send_simple

    assert_equal '1234567890', sms.result[0].recipient
  end

  #
  # Test number input with + and ()
  #
  def test_different_recipients7
    test_recipients = '+(1)234567890'
    sms = @twizo.create_sms('test body', test_recipients, 'test sender')

    sms = sms.send_simple

    assert_equal '1234567890', sms.result[0].recipient
  end

  def teardown
    print "\n#{method_name}"
  end

end