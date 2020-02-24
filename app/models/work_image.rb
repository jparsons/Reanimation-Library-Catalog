class WorkImage < ActiveRecord::Base
  belongs_to :work
  mount_uploader :image, ImageUploader

  validates :image, presence: true

end



# == Schema Information
#
# Table name: work_images
#
#  id                 :integer         not null, primary key
#  work_id            :integer
#  created_at         :datetime
#  updated_at         :datetime
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#
