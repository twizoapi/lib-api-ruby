require_relative 'test_init'

=begin

 This file is part of the Twizo php api

 (c) Twizo <info@twizo.com>

 For the full copyright and license information, please view the LICENSE
 File that was distributed with this source code.

=end

class TestWidget < TestInit

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
      widget = @twizo.create_widget(NUMBER1)
      widget.send
    end
  end

  #
  # Test creation of a widget session
  #
  def test_create_widget
    widget = @twizo.create_widget(nil)

    test_recipient = NUMBER1

    widget.params.recipient = test_recipient

    widget = widget.send

    assert_equal test_recipient, widget.recipient
    assert_not_nil widget.sessionToken
  end

  #
  # Test widget session allowed types
  #
  def test_widget_type
    widget = @twizo.create_widget(nil)
    widget.params.allowed_types = ['sms']

    test_recipient = NUMBER1

    widget.params.recipient = test_recipient

    widget = widget.send

    assert_equal test_recipient, widget.recipient
    assert_equal ['sms'], widget.allowedTypes
  end

  #
  # Test widget session allowed types invalid
  #
  def test_widget_type_invalid
    widget = @twizo.create_widget(nil)
    widget.params.allowed_types = 'sms'

    test_recipient = NUMBER1

    widget.params.recipient = test_recipient

    assert_raise Twizo::TwizoError do
      widget = widget.send
    end
  end

  #
  # Test creation of widget and get status
  #
  def test_get_widget_status
    widget = @twizo.create_widget(nil)

    test_recipient = NUMBER1

    widget.params.recipient = test_recipient

    widget = widget.send

    status = @twizo.get_widget_status(widget.sessionToken, widget.recipient)

    assert_equal widget.sessionToken, status.sessionToken
    assert_equal test_recipient, status.recipient
  end

  def teardown
    print "\n#{method_name}"
  end

end