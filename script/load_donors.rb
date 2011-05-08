require 'hpricot'

## DONORS ## 
xml_document = Hpricot(File.open("#{RAILS_ROOT}/public/system/legacy_data/donors_items.xml"))
xml_document.search("//row").each {|node|

  names = node.search("/donor/data")
  items = node.search("/item_id")
  names.each_with_index {|e, i|
    #puts item.first.inner_html
    unless e.inner_html().blank?
     
      item = Item.find(items.first.inner_html())
      donor = Donor.find_or_create_by_name(e.inner_html())

      item.donors << donor if item
    end
  }
}