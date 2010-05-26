class ImageSubject < ActiveRecord::Base
  
  has_and_belongs_to_many :subjects
  belongs_to :image_subject_authority
end
