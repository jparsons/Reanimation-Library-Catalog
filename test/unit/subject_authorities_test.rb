require 'test_helper'

class SubjectAuthoritiesTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert SubjectAuthorities.new.valid?
  end
end

# == Schema Information
#
# Table name: subject_authorities
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

