require 'test_helper'

class LanguageTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Language.new.valid?
  end
end

# == Schema Information
#
# Table name: languages
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

