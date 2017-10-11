require_relative 'test_init'

=begin

 This file is part of the Twizo php api

 (c) Twizo <info@twizo.com>

 For the full copyright and license information, please view the LICENSE
 File that was distributed with this source code.

=end

class TestEntity < TestInit

  # Initialize Twizo
  def setup
    client = Twizo::NetHttpClient.new(API_KEY, API_HOST)
    @entity = Twizo::Entity.new(client).extend(Twizo::NumberLookup)
  end

  def test_populate
    # number lookup response
    return_values = JSON.parse('{"_links":{"self":{"href":"https://api-asia-01.twizo.com/v1/numberlookup/submit"}},"_embedded":{"items":[{"applicationTag":"Default application","callbackUrl":null,"countryCode":null,"createdDateTime":"2016-11-29T11:26:46+00:00","imsi":null,"messageId":"asia-01-1.19910.nrl583d65f60cdc75.96102916","msc":null,"networkCode":null,"number":"1234567890","operator":null,"reason":null,"resultType":0,"salesPrice":null,"salesPriceCurrencyCode":null,"status":"no status","statusCode":0,"tag":null,"resultTimestamp":null,"validity":60,"validUntilDateTime":"2016-11-29T11:27:46+00:00","_links":{"self":{"href":"https://api-asia-01.twizo.com/v1/numberlookup/submit/asia-01-1.19910.nrl583d65f60cdc75.96102916"}}}]},"total_items":1}')
    @entity.stubs(:send_api_call).returns(return_values)

    populate = @entity.populate('1', nil, nil)

    assert_true populate.is_a?(Twizo::Result)
    assert_nil populate.result
    assert_raise NoMethodError do
      populate._embedded
    end
  end

  def teardown
    print "\n#{method_name}"
  end

end