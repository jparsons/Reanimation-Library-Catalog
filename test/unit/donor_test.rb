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
#  organization_name :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#  name              :string(255)
#

