require_relative 'test_init'

=begin

 This file is part of the Twizo php api

 (c) Twizo <info@twizo.com>

 For the full copyright and license information, please view the LICENSE
 File that was distributed with this source code.

=end

class TestBackupCodes < TestInit

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
      backup_codes = @twizo.create_backup_codes(NUMBER1)
      backup_codes.send
    end
  end

  #
  # Test creation of backup codes
  #
  def test_create_backup_codes
    test_identifier = rand(1000..9999).to_s

    backup_codes = @twizo.create_backup_codes(nil)
    backup_codes.params.identifier = test_identifier

    backup_codes = backup_codes.send

    assert_equal test_identifier, backup_codes.identifier
    assert_equal 10, backup_codes.amountOfCodesLeft
    assert_equal 10, backup_codes.codes.length
  end

  #
  # Test verification of backup codes
  #
  def test_verify_backup_codes
    test_identifier = rand(1000..9999).to_s

    backup_codes = @twizo.create_backup_codes(nil)
    backup_codes.params.identifier = test_identifier

    backup_code = backup_codes.send
    backup_code = backup_code.codes[0]

    verification = backup_codes.verify(backup_code)

    assert_equal test_identifier, verification.identifier
  end

  #
  # Test retrievement of remaining backup codes
  #
  def test_get_backup_codes
    test_identifier = rand(1000..9999).to_s

    backup_codes = @twizo.create_backup_codes(nil)
    backup_codes.params.identifier = test_identifier

    backup_codes.send

    check = @twizo.get_backup_code(test_identifier)

    assert_equal test_identifier, check.identifier
    assert_not_nil check.amountOfCodesLeft
  end

  #
  # Test updating the backup codes
  #
  def test_update_backup_codes
    test_identifier = rand(1000..9999).to_s

    backup_codes = @twizo.create_backup_codes(nil)
    backup_codes.params.identifier = test_identifier

    backup_codes = backup_codes.update

    assert_equal test_identifier, backup_codes.identifier
    assert_equal 10, backup_codes.amountOfCodesLeft
    assert_equal 10, backup_codes.codes.length
  end

  #
  # Test deletion of backup codes
  #
  def test_delete_backup_codes
    test_identifier = rand(1000..9999).to_s

    backup_codes = @twizo.create_backup_codes(nil)
    backup_codes.params.identifier = test_identifier

    backup_codes = backup_codes.delete

    assert_equal '204', backup_codes.code
  end

  def teardown
    print "\n#{method_name}"
  end

end