require 'hpricot'

Item.destroy_all
Subject.destroy_all
Donor.destroy_all

xml_document = Hpricot(File.open("#{RAILS_ROOT}/db/legacy/item.xml"))
xml_document.search("//row").each {|node|
  params = {}
  nodes = %w(title subtitle publisher publisher_city publisher_state publisher_country extent copyright item_size call_number collection_number item_id barcode metadata_notes corporate_author isbn_issn edition notes series_name location)
  fields = %w(title subtitle publisher_name publisher_city publisher_state publisher_country extent copyright item_size call_number collection_name legacy_id barcode metadata_notes corporate_author isbn_issn edition notes series_name location)
  nodes.each_with_index do |name, i|
    elements = node.search(name+"/data")
    content = elements.inner_html()
    if content.blank?
      elements = node.search(name)
      content = elements.inner_html()
    end
    content ||= ""
    params[fields[i].to_sym] = content.gsub(/&apos;/, "'").gsub(/&amp;/, "&")
    #puts "#{fields[i]} = #{content}"
      
  end
  item = Item.create(params)
  subjects = node.search("subject_name/data")
  subject_authorities = node.search("subject_authority/data")
  subjects.each_with_index {|subject, i|
    a = SubjectAuthority.find_or_create_by_name(subject_authorities[i].inner_html())
    s = Subject.find_or_create_by_name_and_subject_authority_id(subject.inner_html().gsub(/&apos;/, "'").gsub(/&amp;/, "&"), a.id)
    item.subjects << s
  }
  creators_first = node.search("creator_first/data")
  creators_last= node.search("creator_last/data")
  creators_middle = node.search("creator_middle/data")
  creators_type = node.search("creator_type/data")
  
  unless creators_last.blank?
    creators_last.each_with_index {|c, idx| 
      c = Creator.create(:last_name => c.inner_html, :first_name => creators_first[idx].inner_html, :middle_name => creators_middle[idx].inner_html, :creator_type => creators_type[idx].inner_html)
      item.creators << c
    }
  end
  
  if File.exists?("#{RAILS_ROOT}/../../../public_html/images/#{item.legacy_id}b_thumb.jpg")
    puts "found one"
    item.cover_image = File.open("#{RAILS_ROOT}/../../../public_html/images/#{item.legacy_id}b_thumb.jpg")
    item.save!
  end

}

## VENDORS ## 
xml_document = Hpricot(File.open("#{RAILS_ROOT}/db/legacy/vendors.xml"))
xml_document.search("//row").each {|node|
  params = {}
  nodes = %w(vendor_name vendor_street vendor_city vendor_state vendor_zip vendor_country vendor_url vendor_phone vendor_notes vendor_id)
  fields = %w(name street city state zip country url phone notes legacy_id)
  nodes.each_with_index do |name, i|
    elements = node.search(name+"/data")
    content = elements.inner_html()
    if content.blank?
      elements = node.search(name)
      content = elements.inner_html()
    end
    content ||= ""
    params[fields[i].to_sym] = content.gsub(/&apos;/, "'").gsub(/&amp;/, "&")
    #puts "#{fields[i]} = #{content}"
      
  end
  vendor = Vendor.create(params)
}

## DONORS ## 
xml_document = Hpricot(File.open("#{RAILS_ROOT}/db/legacy/donors.xml"))
xml_document.search("//row").each {|node|
  elements = node.search("/donor/data")
  elements.each {|e|
    Donor.find_or_create_by_name(e.inner_html())  
  }
}

## ACQUISITIONS ##
xml_document = Hpricot(File.open("#{RAILS_ROOT}/db/legacy/acquisitions.xml"))
xml_document.search("//row").each {|node|
  legacy_id = ""
  vendor_legacy_id = ""
  legacy_id_node = node.search("/item_id/data")  
  if legacy_id_node.count == 1
    legacy_id = legacy_id_node.inner_html()
    vendor_id_node = node.search("/vendor_id/data")
    if vendor_id_node.count == 1 
      vendor_legacy_id = vendor_id_node.inner_hml()
    end
    params = {}
    nodes = %w(date_acquired price_paid acquisition_type gift_type acquisition_note acquired_for)
    fields = %w(date_acquired price_paid acquisition_type gift_type acquisition_note acquired_for)
    nodes.each_with_index do |name, i|
      elements = node.search(name+"/data")
      content = elements.inner_html()
      if content.blank?
        elements = node.search(name)
        content = elements.inner_html()
      end
      content ||= ""
      params[fields[i].to_sym] = content.gsub(/&apos;/, "'").gsub(/&amp;/, "&")
      #puts "#{fields[i]} = #{content}"

    end
    
    item = Item.find_by_legacy_id(legacy_id)
    if item
      item.update_attributes(params)
      if vendor_legacy_id
        vendor = Vendor.find_by_legacy_id(vendor_legacy_id)
        if vendor
          item.vendor = vendor
        end
      end
    end
    
  end
    
}
