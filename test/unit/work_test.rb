require 'test_helper'

class WorkTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Work.new.valid?
  end
end


# == Schema Information
#
# Table name: works
#
#  id                    :integer         not null, primary key
#  title                 :string(255)
#  medium                :string(255)
#  size                  :string(255)
#  year_created          :integer
#  work_type             :string(255)
#  created_at            :datetime
#  updated_at            :datetime
#  creator_id            :integer
#  legacy_id             :integer
#  textfile_file_name    :string(255)
#  textfile_content_type :string(255)
#  textfile_file_size    :integer
#  textfile_updated_at   :datetime
#

