class ImageType < ActiveRecord::Base

  has_and_belongs_to_many :digital_assets

end
