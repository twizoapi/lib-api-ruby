require_relative 'test_init'

=begin

 This file is part of the Twizo php api

 (c) Twizo <info@twizo.com>

 For the full copyright and license information, please view the LICENSE
 File that was distributed with this source code.

=end

class TestClient < TestInit

  def test_user_agent
    user_agent = Twizo::Client.new(API_KEY, API_HOST).user_agent
    assert_equal "Twizo-ruby-lib/#{Twizo::Client::LIB_VERSION} Ruby/#{RUBY_VERSION}/#{RUBY_PLATFORM}", user_agent
  end

  def test_get_url
    url = Twizo::NetHttpClient.new(API_KEY, API_HOST).get_url('test')
    assert_equal "https://#{API_HOST}/#{Twizo::Client::API_VERSION}/test", url
  end

  def teardown
    print "\n#{method_name}"
  end

end