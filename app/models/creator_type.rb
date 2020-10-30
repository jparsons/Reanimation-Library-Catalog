class CreatorType < ActiveRecord::Base
  def attributes_protected_by_default
    ['type']
  end
	has_many :creators
	validates :name, :presence => true
end
