class Work < ActiveRecord::Base
  has_and_belongs_to_many :items
  has_and_belongs_to_many :exhibitions
  has_many :work_images, :dependent => :destroy
  has_and_belongs_to_many :work_creators

  mount_uploader :textfile, TextfileUploader

  validates :textfile, presence: true
  

  default_scope { order('year_created desc, title asc') }


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
