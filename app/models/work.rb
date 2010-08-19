class Work < ActiveRecord::Base
  has_and_belongs_to_many :items
  has_and_belongs_to_many :exhibitions
  has_many :work_images, :dependent => :destroy
  has_and_belongs_to_many :work_creators
  has_attached_file :textfile
  default_scope :order=>"year_created desc"
  
  
  accepts_nested_attributes_for :work_creators, :allow_destroy=>true, :reject_if=> proc { |attributes| attributes.all? {|k,v| v.blank?} }
  
  accepts_nested_attributes_for :work_images, :allow_destroy=>true
  
  def creator_name 
    work_creator.nil? ? "Unknown" : work_creator.display_name
  end
end

# == Schema Information
#
# Table name: works
#
#  id           :integer         not null, primary key
#  title        :string(255)
#  medium       :string(255)
#  size         :string(255)
#  year_created :integer
#  genre        :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

