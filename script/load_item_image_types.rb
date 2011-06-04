require 'hpricot'


xml_document = Hpricot(File.open("#{RAILS_ROOT}/public/system/legacy_data/items_imagetypes.xml"))
xml_document.search("//row").each {|node|
  id = node.search("item_id/data").first
  #item = Item.find(id)
  if id
    item = Item.find(id.inner_html())
    if item
      image_type_nodes = node.search("image_type/data")
      for image_type_node in image_type_nodes
        image_type = ImageType.find_or_create_by_name(image_type_node.inner_html)
        item.image_types << image_type unless item.image_types.include?(image_type)
      end
      item.save!
    end
  end

}