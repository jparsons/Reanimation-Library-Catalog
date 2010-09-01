module ItemsHelper

 def pagination_links(current_letter=nil)
   if current_letter.nil?
     string = content_tag("span", "1-9 | ", :class=>"current")
   else 
     string = link_to("1-9 | ", items_path(:letter=>"1-9"))
   end
   ("A".."Z").to_a.each {|letter|
     if letter_options.include?(letter) && current_letter != letter
       string = string + link_to(letter, items_path(:letter=>letter))
     else
       string = string + content_tag("span", letter, :class=>"current")
     end
     string = string + " | " unless letter == "Z"
   }
  return content_tag("div", string, :class=>'pagination')
 end
 
 def letter_options
   @letter_options_list ||= (Item.all.collect!{ |c| c.alphabetical_title.first.upcase }.uniq! || []).sort!
 end

end
