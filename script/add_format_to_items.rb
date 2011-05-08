require 'hpricot'
xml_document = Hpricot(File.open("#{RAILS_ROOT}/public/system/legacy_data/item.xml"))
xml_document.search("//row").each  do |node|
  id = node.search("item_id").inner_html()
  formats = node.search("format/data")
  content = formats.inner_html()
  if content.blank?
    elements = node.search("format")
    content = elements.inner_html()
    content = "" if content == "<data></data>"
  end
  puts content
  item = Item.find_by_id(id)
  puts item.title
  item.update_attribute(:format, content)
  
end