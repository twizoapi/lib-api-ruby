require_relative 'test_init'

=begin

 This file is part of the Twizo php api

 (c) Twizo <info@twizo.com>

 For the full copyright and license information, please view the LICENSE
 File that was distributed with this source code.

=end

class TestNumberLookup < TestInit

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
      number_lookup = @twizo.create_number_lookup(NUMBER1)
      number_lookup.send
    end
  end

  #
  # Test creation of number lookup with multiple numbers
  #
  def test_create_number_lookup
    number_lookup = @twizo.create_number_lookup(nil)

    test_numbers = [NUMBER1, NUMBER2]
    test_tag = 'test tag'
    test_validity = 259200
    test_result_type = 0
    test_callback_url = nil

    number_lookup.params.numbers = test_numbers
    number_lookup.params.tag = test_tag
    number_lookup.params.validity = test_validity
    number_lookup.params.result_type = test_result_type
    number_lookup.params.callback_url = test_callback_url

    number_lookup = number_lookup.send

    assert_equal test_numbers[0], number_lookup.result[0].number
    assert_equal test_tag, number_lookup.result[0].tag
    assert_equal 'no status', number_lookup.result[0].status

    assert_equal test_numbers[1], number_lookup.result[1].number
    assert_equal test_tag, number_lookup.result[1].tag
    assert_equal 'no status', number_lookup.result[1].status
  end

  #
  # Test creation of number lookup with a single number
  #
  def test_create_number_lookup_single
    number_lookup = @twizo.create_number_lookup(nil)

    test_number = NUMBER1
    number_lookup.params.numbers = test_number

    number_lookup = number_lookup.send

    assert_equal test_number, number_lookup.result[0].number
    assert_equal 'no status', number_lookup.result[0].status
  end

  #
  # Test creation of number lookup and get status
  #
  def test_number_lookup_status
    test_number = NUMBER1

    number_lookup = @twizo.create_number_lookup(test_number)
    number_lookup = number_lookup.send

    test_message_id = number_lookup.result[0].messageId

    status = @twizo.get_number_lookup_status(test_message_id)

    assert_equal test_message_id, status.messageId
    assert_equal test_number, status.number
  end

  #
  # Test creation of number lookup and get results after completion of status
  #
  def test_number_lookup_results
    test_number = NUMBER1

    number_lookup = @twizo.create_number_lookup(test_number)
    number_lookup.params.result_type = 2

    number_lookup = number_lookup.send

    x = false
    until x
      if @twizo.get_number_lookup_status(number_lookup.result[0].messageId).status == 'no status'
        sleep 0.5
        next
      end
      x = true
    end

    results = @twizo.get_number_lookup_results

    assert_not_nil results.batchId

    results.result.each do |item|
      assert_not_nil item.number
      assert_not_nil item.messageId
    end
  end

  #
  # Test number input normal
  #
  def test_different_numbers1
    test_numbers = '1234567890'
    number_lookup = @twizo.create_number_lookup(test_numbers)

    number_lookup = number_lookup.send

    assert_equal '1234567890', number_lookup.result[0].number
  end

  #
  # Test number input with +
  #
  def test_different_numbers2
    test_numbers = '+1234567890'
    number_lookup = @twizo.create_number_lookup(test_numbers)

    number_lookup = number_lookup.send

    assert_equal '1234567890', number_lookup.result[0].number
  end

  #
  # Test number input with 00
  #
  def test_different_numbers3
    test_numbers = '00001234567890'
    number_lookup = @twizo.create_number_lookup(test_numbers)

    number_lookup = number_lookup.send

    assert_equal '1234567890', number_lookup.result[0].number
  end

  #
  # Test number input with ' '
  #
  def test_different_numbers4
    test_numbers = '1 23 45 67 89 0'
    number_lookup = @twizo.create_number_lookup(test_numbers)

    number_lookup = number_lookup.send

    assert_equal '1234567890', number_lookup.result[0].number
  end

  #
  # Test number input with Characters
  #
  def test_different_numbers5
    test_numbers = '1 23 A5 67 89 o'

    assert_raise Twizo::TwizoError do
      number_lookup = @twizo.create_number_lookup(test_numbers)
      number_lookup.send
    end
  end

  #
  # Test number input with ()
  #
  def test_different_numbers6
    test_numbers = '(1)234567890'
    number_lookup = @twizo.create_number_lookup(test_numbers)

    number_lookup = number_lookup.send

    assert_equal '1234567890', number_lookup.result[0].number
  end

  #
  # Test number input with + and ()
  #
  def test_different_numbers7
    test_numbers = '+(1)234567890'
    number_lookup = @twizo.create_number_lookup(test_numbers)

    number_lookup = number_lookup.send

    assert_equal '1234567890', number_lookup.result[0].number
  end

  def teardown
    print "\n#{method_name}"
  end

end