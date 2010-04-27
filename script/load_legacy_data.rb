require 'hpricot'

Item.destroy_all

xml_document = Hpricot(File.open("#{RAILS_ROOT}/db/legacy/item.xml"))
xml_document.search("//row").each {|node|
  params = {}
  nodes = %w(title subtitle publisher publisher_city publisher_state publisher_country extent copyright item_size call_number collection_number item_id)
  fields = %w(title subtitle publisher_name publisher_city publisher_state publisher_country extent copyright item_size call_number collection_name legacy_id)
  nodes.each_with_index do |name, i|
    elements = node.search(name+"/data")
    content = elements.inner_html()
    if content.blank?
      elements = node.search(name)
      content = elements.inner_html()
    end
    content ||= ""
    params[fields[i].to_sym] = content
    #puts "#{fields[i]} = #{content}"
      
  end
  i = Item.create(params)
  subjects = node.search("subject_name/data")
  subjects.each {|subject|
    s = Subject.find_or_create_by_name(subject.inner_html())
    i.subjects << s
  }
    #unless subjects.nil?
    #  #subjects = subject_node_list.search("data")
    #  subjects.each {|subject_node|
    #    s = Subject.find_or_create_by_name(subject_node.search("data").inner_html())
    #    i.subjects << s
    #  }
    #end
    
    
  
  #params[:title] = NodeFunctions.get_node(node, "title")
  #puts params[:title]
  #params[:subtitle] = 
  #params[:publisher_name] =
  #params[:publisher_city] =
  #params[:publisher_state] = 
  #params[:publisher_country] =
  #params[:extent] = 
  #params[:copyright] = 
  #params[:item_size] = 
  #params[:call_number] =
  #params[:collection_id] =
  #params[:legacy_id] = 
  
  
  #Item.create(params)
  
}
