items = Item.all(:order=>:call_number)
File.open("export.csv", 'w') {|f|
    items.each { |i|
          unless i.call_number.blank?
                  f.write("\"#{i.id}\",\"#{i.call_number}\",\"#{i.display_title.gsub(/"/, '\"')}\"\n")
                      end
            }
}

