class Item < ActiveRecord::Base
  
  named_scope :non_alphanumerical, {:conditions => "not (alphabetical_title like 'a%' or alphabetical_title like 'b%' or alphabetical_title like 'c%' or alphabetical_title like 'd%' or alphabetical_title like 'e%' or alphabetical_title like 'f%' or alphabetical_title like 'g%' or alphabetical_title like 'h%' or alphabetical_title like 'i%' or alphabetical_title like 'j%' or alphabetical_title like 'k%' or alphabetical_title like 'l%' or alphabetical_title like 'm%' or alphabetical_title like 'n%' or alphabetical_title like 'o%' or alphabetical_title like 'p%' or alphabetical_title like 'q%' or alphabetical_title like 'r%' or alphabetical_title like 's%' or alphabetical_title like 't%' or alphabetical_title like 'u%' or alphabetical_title like 'v%' or alphabetical_title like 'w%' or alphabetical_title like 'x%' or alphabetical_title like 'y%' or alphabetical_title like 'z%')", :order => "alphabetical_title"}
  named_scope :starting_with, lambda{|letter|{:conditions => ["alphabetical_title LIKE ?", "#{letter}%"], :order => "alphabetical_title"}}
  has_and_belongs_to_many :subjects
  has_many :creators, :dependent=>:destroy
  has_attached_file :cover_image, :styles => { :thumb => "200x200>" }, :default_url => "/catalog/images/missing_:style_cover_image.png"

  
  before_save :create_title_for_alphabetizing
  
  def create_title_for_alphabetizing
    what_to_remove = REMOVE_FROM_BEGINNING_OF_TITLES.map{|w| "^#{w}" }.join("|")
    r = Regexp.new(what_to_remove,true)
    self.alphabetical_title = title.gsub(r, "").strip
  end

end


