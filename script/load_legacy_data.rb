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
    params[fields[i].to_sym] = CGI::unescapeHTML(content)
    #puts "#{fields[i]} = #{content}"
      
  end
  i = Item.create(params)
  subjects = node.search("subject_name/data")
  subjects.each {|subject|
    s = Subject.find_or_create_by_name(CGI::unescapeHTML(subject.inner_html()))
    i.subjects << s
  }
  creators_first = node.search("creator_first/data")
  creators_last= node.search("creator_last/data")
  creators_middle = node.search("creator_middle/data")
  creators_type = node.search("creator_type/data")
  
  unless creators_last.blank?
    creators_last.each_with_index {|c, idx| 
      c = Creator.create(:last_name => c.inner_html, :first_name => creators_first[idx].inner_html, :middle_name => creators_middle[idx].inner_html, :creator_type => creators_type[idx].inner_html)
      i.creators << c
    }
  end
  
  if File.exists?("#{RAILS_ROOT}/../../../public_html/images/#{i.legacy_id}b_thumb.jpg")
    puts "found one"
    i.cover_image = File.read("#{RAILS_ROOT}/../../../public_html/images/#{i.legacy_id}b_thumb.jpg")
    i.save  
  end


  
}
