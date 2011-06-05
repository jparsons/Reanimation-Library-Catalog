require 'hpricot'
xml_document = Hpricot(File.open("#{RAILS_ROOT}/public/system/legacy_data/acquisitions.xml"))
xml_document.search("//row").each  do |node|
  id = node.attributes["recordid"] 
  price_paid = node.search("price_paid/data")
  content = price_paid.inner_html()
  if content.blank?
    elements = node.search("price_paid")
    content = elements.inner_html()
    content = "" if content == "<data></data>"
  end
  puts content
  item = Item.find_by_legacy_record_id(id)
  puts item.title
  item.update_attribute(:price_paid, content)
  
end
