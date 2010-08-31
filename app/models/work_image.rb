class WorkImage < ActiveRecord::Base
  belongs_to :work
  
  has_attached_file :image,
    :styles => {
      :thumb=> "100x100#",
      :large =>   "400x400>" }
end


# == Schema Information
#
# Table name: work_images
#
#  id         :integer         not null, primary key
#  work_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

