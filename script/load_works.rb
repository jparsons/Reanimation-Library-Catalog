require 'hpricot'

Work.destroy_all
WorkCreator.destroy_all
WorkImage.destroy_all


xml_document = Hpricot(File.open("#{RAILS_ROOT}/public/system/legacy_data/works.xml"))
xml_document.search("//row").each {|node|
  work_id_nodes = node.search("work_id/data")
  titles = node.search("art_title/data")
  work_types = node.search("work_type/data")
  sizes = node.search("size/data")
  mediums = node.search("medium/data")
  year_createds = node.search("year_created/data")
  work_id_nodes.each_with_index {|work_id_node, i|
    work = Work.new(
      :title => titles[i].inner_html(), 
      :size => sizes[i].inner_html().gsub(/&quot;/, '"'), 
      :medium => mediums[i].inner_html(), 
      :work_type => work_types[i].inner_html(), 
      :legacy_id => work_id_node.inner_html(),
      :year_created => year_createds[i].inner_html())
    work.save!
  }
}

xml_document = xml_document = Hpricot(File.open("#{RAILS_ROOT}/public/system/legacy_data/work_creators.xml"))
xml_document.search("//row").each {|node|
  work_ids = node.search("work_id/data")
  work_creators = node.search("work_creator/data")
  work_ids.each_with_index {|work_id, i|
    unless work_id.blank? || work_creators[i].nil?
      
      work = Work.find_by_legacy_id(work_id.inner_html())
      work_creator = WorkCreator.find_or_create_by_name(work_creators[i].inner_html())
      work.work_creators << work_creator
    end
  }
  
}

xml_document = xml_document = Hpricot(File.open("#{RAILS_ROOT}/public/system/legacy_data/items_works.xml"))
xml_document.search("//row").each {|node|
  work_ids = node.search("work_id/data")
  item_ids = node.search("item_id/data")
  work_ids.each_with_index {|work_id, i|
    work = Work.find_by_legacy_id(work_id.inner_html())
    item = Item.find(item_ids[i].inner_html())
    work.items << item
  }
}
    