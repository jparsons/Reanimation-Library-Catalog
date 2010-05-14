require 'test_helper'

class DonorTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Donor.new.valid?
  end
end

# == Schema Information
#
# Table name: donors
#
#  id                :integer         not null, primary key
#  first_name        :string(255)
#  last_name         :string(255)
#  organization_name :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#

