require 'hpricot'
xml_document = Hpricot(File.open("#{RAILS_ROOT}/db/legacy/item.xml"))
xml_document.search("//row").each {|node|
  puts "hello"
  params = {}
    nodes = %w(title subtitle publisher publisher_city publisher_state publisher_country extent copyright item_size call_number collection_number item_id)
    fields = %w(title subtitle publisher_name publisher_city publisher_state publisher_country extent copyright item_size call_number collection_name legacy_id)
    nodes.each_with_index do |name, i|
      node_set = node.search(name)
      unless node_set.nil?
        child = node_set.first
        unless child.nil? || child.children.nil?
          unless child.children.first.nil?
            content = child.children.first.inner_html()
          end
        end
      end
      content ||= ""
      params[fields[i].to_sym] = content
      
    end
    i = Item.create(params)
    subject_node_list = node.search("subject_name")
    unless subject_node_list.nil?
      subjects = subject_node_list.search("DATA")
      subjects.each {|subject_node|
        s = Subject.find_or_create_by_name(subject_node.inner_html())
        i.subjects << s
      }
    end
    
    
  
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
