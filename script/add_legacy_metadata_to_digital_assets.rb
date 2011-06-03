require 'hpricot'


xml_document = Hpricot(File.open("#{RAILS_ROOT}/public/system/legacy_data/images.xml"))
xml_document.search("//row").each {|node|
  image_ids = node.search("image_id/data") 
  colors = node.search("images_imagecolor/data")  
  digital_asset = nil
  image_ids.each_with_index do |image_name_node, i|
    if digital_asset.nil? || digital_asset.scan_file_name != image_name_node.inner_html() + ".jpg"
      digital_asset = DigitalAsset.find_by_scan_file_name(image_name_node.inner_html() + ".jpg")
    end
    if digital_asset
      digital_asset.update_attribute(:color, colors[i].inner_html().gsub(/&amp;/,"&"))
      puts "#{digital_asset.id} #{colors[i].inner_html().gsub(/&amp;/,"&")}" unless colors[i].inner_html().blank?
    end
  end
}
xml_document = Hpricot(File.open("#{RAILS_ROOT}/public/system/legacy_data/image_types.xml"))
xml_document.search("//row").each {|node|
  image_ids = node.search("image_id/data") 
  image_types = node.search("images_imagetype/data")  
  digital_asset = nil
  image_ids.each_with_index do |image_name_node, i|
    if digital_asset.nil? || digital_asset.scan_file_name != image_name_node.inner_html() + ".jpg"
      digital_asset = DigitalAsset.find_by_scan_file_name(image_name_node.inner_html() + ".jpg")
    end
    if digital_asset
      digital_asset.image_types << ImageType.find_or_create_by_name(image_types[i].inner_html().gsub(/&amp;/,"&"))
      puts "#{digital_asset.id} #{image_types[i].inner_html().gsub(/&amp;/,"&")}"
    end
  end
}
xml_document = Hpricot(File.open("#{RAILS_ROOT}/public/system/legacy_data/image_subjects.xml"))
xml_document.search("//row").each {|node|
  subjects = node.search("imagesubject_name/data")
  authorities = node.search("imagesubject_authority/data")
  subjects.each_with_index do |subject, i|
    puts authorities[i].inner_html
    digital_asset_subject = DigitalAssetSubject.find_or_create_by_name_and_authority(subject.inner_html().gsub(/&amp;/,"&"), authorities[i].inner_html)
  end
}
xml_document = Hpricot(File.open("#{RAILS_ROOT}/public/system/legacy_data/image_image_subjects.xml"))
xml_document.search("//row").each {|node|
  image_ids = node.search("image_id/data") 
  subjects = node.search("image_subject_name/data")  
  digital_asset = nil
  image_ids.each_with_index do |image_name_node, i|
    if digital_asset.nil? || digital_asset.scan_file_name != image_name_node.inner_html() + ".jpg"
      digital_asset = DigitalAsset.find_by_scan_file_name(image_name_node.inner_html() + ".jpg")
    end
    if digital_asset
      digital_asset_subject = DigitalAssetSubject.find_or_create_by_name(subjects[i].inner_html)
      digital_asset.digital_asset_subjects << digital_asset_subject
    end
  end
}

