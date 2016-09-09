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
   if user_signed_in? && current_user.is_administrator?
     (Item.all.collect!{ |c| c.alphabetical_title.first.upcase }.uniq! || []).sort!
   else 
     (Item.published.collect!{ |c| c.alphabetical_title.first.upcase }.uniq! || []).sort!
   end
 end

  def determine_sort_order(field, current_field, current_order)
    if field == current_field
      if current_order == "ASC"
        "DESC"
      else
        "ASC"
      end
    else
      "ASC"
    end
  end

  def show_order_image(field, current_field, current_order)
    if field == current_field
      if current_order == "DESC"
        image_tag("desc.png")
      else
        image_tag("asc.png")
      end
    end
  end

  def print_unless_blank(field_value, label)
    unless field_value.blank?
      content_tag("div", content_tag("div", label + ":", :class=>"item-label") + content_tag("div", raw(field_value), :class=>"item-content"), :class=>"item-row item-#{label.downcase.gsub(/ /, "-")}")
    end
  end

end
