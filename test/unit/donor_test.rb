require 'test_helper'

class DonorTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Donor.new.valid?
  end
end
