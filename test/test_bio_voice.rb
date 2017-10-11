require_relative 'test_init'

=begin

 This file is part of the Twizo php api

 (c) Twizo <info@twizo.com>

 For the full copyright and license information, please view the LICENSE
 File that was distributed with this source code.

=end

class TestBioVoice < TestInit

  # Initialize Twizo
  def setup
    @twizo = Twizo::Twizo.new(API_KEY, API_HOST)
  end

  # Test creation of bio voice
  def test_create_bio_voice_registration
    test_number = rand(11111111..999999999).to_s

    bio_voice = @twizo.create_bio_voice_registration(nil)
    bio_voice.params.recipient = test_number

    bio_voice = bio_voice.send

    assert_equal test_number, bio_voice.recipient
  end

  # Test status of bio voice
  def test_bio_voice_registration_status
    test_number = rand(11111111..999999999).to_s

    bio_voice = @twizo.create_bio_voice_registration(nil)
    bio_voice.params.recipient = test_number

    bio_voice = bio_voice.send

    registration_id = bio_voice.registrationId

    status = @twizo.get_bio_voice_registration_status(registration_id)

    assert_equal registration_id, status.registrationId
  end

  # Test status of bio voice
  def test_bvr_no_recipient

    bio_voice = @twizo.create_bio_voice_registration(nil)

    assert_raise Twizo::TwizoError do
      bio_voice = bio_voice.send
    end
  end

  def teardown
    print "\n#{method_name}"
  end

end