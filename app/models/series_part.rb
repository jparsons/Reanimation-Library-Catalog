class SeriesPart < ActiveRecord::Base
  belongs_to :series
  belongs_to :item
end

# == Schema Information
#
# Table name: series_parts
#
#  id                :integer         not null, primary key
#  item_id           :integer
#  series_id         :integer
#  position          :integer
#  volume_identifier :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#

