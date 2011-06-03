class ImageType < ActiveRecord::Base

  has_and_belongs_to_many :digital_assets
  has_and_belongs_to_many :items
end
