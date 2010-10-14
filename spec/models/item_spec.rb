require 'spec_helper'

describe Item do
  before(:each) do
    @valid_attributes = {
      
    }
  end

  it "should create a new instance given valid attributes" do
    Item.create!(@valid_attributes)
  end
end


# == Schema Information
#
# Table name: items
#
#  id                       :integer         not null, primary key
#  title                    :string(255)
#  created_at               :datetime
#  updated_at               :datetime
#  alphabetical_title       :string(255)
#  subtitle                 :string(255)
#  publisher_name           :string(255)
#  publisher_city           :string(255)
#  publisher_state          :string(255)
#  publisher_country        :string(255)
#  extent                   :string(255)
#  copyright                :string(255)
#  item_size                :string(255)
#  call_number              :string(255)
#  collection_name          :string(255)
#  legacy_id                :integer
#  cover_image_file_name    :string(255)
#  cover_image_content_type :string(255)
#  cover_image_file_size    :integer
#  cover_image_updated_at   :datetime
#  barcode                  :string(255)
#  has_marc_record          :boolean
#  metadata_notes           :text
#  corporate_author         :string(255)
#  isbn_issn                :string(255)
#  language_id              :integer
#  is_government_document   :boolean
#  edition                  :string(255)
#  notes                    :text
#  series_name              :string(255)
#  needs_translation        :boolean
#  location                 :string(255)
#  is_marked                :boolean
#  vendor_id                :integer
#  date_acquired            :date
#  price_paid               :decimal(8, 2)
#  acquisition_type         :string(255)
#  gift_type                :string(255)
#  acquisition_note         :text
#  acquired_for             :string(255)
#  legacy_record_id         :integer
#  cataloging_status        :string(255)
#

