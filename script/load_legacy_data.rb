require 'hpricot'

Item.destroy_all
Subject.destroy_all
Donor.destroy_all

xml_document = Hpricot(File.open("#{RAILS_ROOT}/db/legacy/item.xml"))
xml_document.search("//row").each {|node|
  legacy_record_id =  node.attributes["recordid"]
  params = {}
  nodes = %w(title subtitle publisher publisher_city publisher_state publisher_country extent copyright item_size call_number collection_number item_id barcode metadata_notes corporate_author isbn_issn edition notes series_name location)
  fields = %w(title subtitle publisher_name publisher_city publisher_state publisher_country extent copyright item_size call_number collection_name legacy_id barcode metadata_notes corporate_author isbn_issn edition notes series_name location)
  nodes.each_with_index do |name, i|
    elements = node.search(name+"/data")
    content = elements.inner_html()
    if content.blank?
      elements = node.search(name)
      content = elements.inner_html()
      content = "" if content == "<data></data>"
    end
    content ||= ""
    params[fields[i].to_sym] = content.gsub(/&apos;/, "'").gsub(/&amp;/, "&")
    #puts "#{fields[i]} = #{content}"

  end
  params["legacy_record_id"] = legacy_record_id
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
    item.cover_image = File.open("#{RAILS_ROOT}/../../../public_html/images/#{item.legacy_id}b_thumb.jpg")
    item.save!
  end

}

## VENDORS ## 
xml_document = Hpricot(File.open("#{RAILS_ROOT}/db/legacy/vendors.xml"))
xml_document.search("//row").each {|node|
  legacy_record_id = node.attributes["recordid"]
  params = {}
  nodes = %w(vendor_name vendor_street vendor_city vendor_state vendor_zip vendor_country vendor_url vendor_phone vendor_notes)
  fields = %w(name street city state zip country url phone notes)
  nodes.each_with_index do |name, i|
    elements = node.search(name+"/data")
    content = elements.inner_html()
    if content.blank?
      elements = node.search(name)
      content = elements.inner_html()
      content = "" if content == "<data></data>"
    end
    content ||= ""
    params[fields[i].to_sym] = content.gsub(/&apos;/, "'").gsub(/&amp;/, "&")
    #puts "#{fields[i]} = #{content}"
      
  end
  puts params[:name]
  unless params[:name].blank?
    vendor = Vendor.find_or_create_by_name_and_street_and_city_and_state_and_zip_and_country_and_url_and_phone_and_notes(params[:name], params[:street], params[:city], params[:state], params[:zip], params[:country], params[:url], params[:phone], params[:notes])
    item = Item.find_by_legacy_record_id(legacy_record_id)
    item.vendor = vendor
    item.save
  end
}

## DONORS ## 
xml_document = Hpricot(File.open("#{RAILS_ROOT}/db/legacy/item_donor.xml"))
xml_document.search("//row").each {|node|

  names = node.search("/donor/data")
  items = node.search("/item_id/data")
  names.each_with_index {|e, i|
    item = Item.find_by_legacy_id(items[i].inner_html())
    donor = Donor.find_or_create_by_name(e.inner_html())

    item.donors << donor if item
  }
}

## ACQUISITIONS ##
xml_document = Hpricot(File.open("#{RAILS_ROOT}/db/legacy/acquisitions.xml"))
xml_document.search("//row").each {|node|
  legacy_id = ""
  vendor_legacy_id = ""
  legacy_record_id = ""
  legacy_record_id = node.attributes["recordid"] 
  unless legacy_record_id.empty?
    vendor_id_node = node.search("/vendor_id/data")
    if vendor_id_node.count == 1 
      vendor_legacy_id = vendor_id_node.inner_hml()
    end
    params = {}
    nodes = %w(date_acquired price_paid acquisitions_type gift_type acquisitions_note acquired_for)
    fields = %w(date_acquired price_paid acquisition_type gift_type acquisition_note acquired_for)
    nodes.each_with_index do |name, i|
      elements = node.search(name+"/data")
      content = elements.inner_html()
      if content.blank?
        elements = node.search(name)
        content = elements.inner_html()
        content = "" if content == "<data></data>"
      end
      content ||= ""
      params[fields[i].to_sym] = content.gsub(/&apos;/, "'").gsub(/&amp;/, "&")
      #puts "#{fields[i]} = #{content}"

    end
    
    item = Item.find_by_legacy_record_id(legacy_record_id)
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
## ACQUISITIONS ##
xml_document = Hpricot(File.open("#{RAILS_ROOT}/db/legacy/items_works.xml"))
xml_document.search("//row").each {|node|
  
  legacy_id_node = node.search("/item_id/data")  
  if legacy_id_node.count == 1
    legacy_id = legacy_id_node.inner_html()
    item = Item.find_by_legacy_id(legacy_id)
    if item 
      title = node.search("/art_title/data")
      title.each_with_index {|t, i|
        title = t.inner_html
        year_created = node.search("/year_created/data")[i].inner_html
        genre = node.search("/work_type/data")[i].inner_html
        medium = node.search("/medium/data")[i].inner_html
        size = node.search("/size/data")[i].inner_html.gsub(/&quot;/, "\"")
        w = Work.find(:first, :conditions=>["title=? and year_created=? and medium=? and size=? and genre=?", title, year_created, medium, size, genre])
        if w.nil?
          w = Work.create(:title=>title, :genre=>genre, :medium=>medium, :size=>size, :year_created=>year_created)
        end
        item.works << w
      }
    end
  end 
  
}

## IMAGES ##
xml_document = Hpricot(File.open("#{RAILS_ROOT}/db/legacy/images.xml"))
xml_document.search("//row").each {|node|
  params = {}
  nodes = %w(images_imagecolor image_marked image_id images_imagetype )
  fields = %w(color is_marked legacy_id image_type) 
  nodes.each_with_index do |name, i|
    elements = node.search(name+"/data")
    content = elements.inner_html()
    if content.blank?
      elements = node.search(name)
      content = elements.inner_html()
      content = "" if content == "<data></data>"
    end
    content ||= ""
    params[fields[i].to_sym] = content
    #puts "#{fields[i]} = #{content}"
      
  end
  image = DigitalAsset.create(params)
  
  subjects = node.search("/image_subject_name/data")
  authorities = node.search("/imagesubject_authority/data")
  subjects.each_with_index {|s, i|
    subject = DigitalAssetSubject.create(:name=>s.inner_html())
    if authorities[i]
      authority = DigitalAssetSubjectAuthority.find_or_create_by_name(authorities[i].inner_html())
      subject.digital_asset_subject_authority = authority
    end
    image.digital_asset_subjects << subject
  }
       
}

xml_document = Hpricot(File.open("#{RAILS_ROOT}/db/legacy/item_images.xml"))
xml_document.search("//row").each {|node| 
  legacy_ids = node.search("/item_id/data")
  unless legacy_ids.first.nil?
    legacy_id = legacy_ids.first.inner_html()
    
    item = Item.find_by_legacy_id(legacy_id)
    unless item.nil?
    image_ids = node.search("image_id/data")
    image_ids.each {|image_node|
      image = DigitalAsset.find_by_legacy_id(image_node.inner_html())
      item.digital_assets << image
  
    }
    end
  end
}

## SERIES ##
xml_document = Hpricot(File.open("#{RAILS_ROOT}/db/legacy/serials.xml"))
xml_document.search("//row").each {|node|
  serial_title = node.search("/serial_title/data")
  unless serial_title.inner_html().blank?
    legacy_ids = node.search("/item_id/data").inner_html()
    volume_ids = node.search("/serial_number/data").inner_html()
    
    s = Series.create(:title=>serial_title.inner_html())
    legacy_ids.each_with_index {|l_id, i|
      item = Item.find_by_legacy_id(l_id)
      if item
        sp = SeriesPart.create(:item_id=>item.id, :series_id => s.id, :position=>i+1, :volume_identifier=>volume_ids[i])
      end
    }
   
  end

}

