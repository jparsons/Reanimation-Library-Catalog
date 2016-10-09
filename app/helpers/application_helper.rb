# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  include ActsAsTaggableOn::TagsHelper
  def link_to_if_user_is_admin(condition, name, options = {}, html_options = {}, &block)
    if @current_user && @current_user.is_administrator?
      link_to(condition, name, options, html_options, &block)
    else
      ''
    end
  end
  def add_subform_link(form_builder, classname)
    link_to_function "add #{classname} details", :id => "add-#{classname}-entry-link", :class=>"admin-link" do |page|
      form_builder.fields_for classname.pluralize.to_sym, classname.classify.constantize.new, "#{classname}index".to_sym => 'NEW_RECORD' do |f|
        html = render(:partial => classname, :locals => { :form => f})
        page << "$('#{classname.pluralize}').insert({bottom: '#{escape_javascript(html)}'.replace(/NEW_RECORD/g, new Date().getTime()) });"
      end
    end
  end
  # copied from http://github.com/ryanb/complex-form-examples
  def remove_child_link(name, f)
    f.hidden_field(:_destroy, :value=>"0")
    link_to(name, "javascript:void(0)", :class=>"admin-link remove-link")
  end
   # need to have a way to replace the dropdown with the new child form and vice versa ...
   def new_association_link(name, f, model, additional_javascript = "")
     fields = new_child_fields(f, model.to_sym)
     link_to_function(name, raw("replace_content(this, \"#{model}\", \"#{escape_javascript(fields)}\");$(\"#add-#{model}-select-link\").show();$(\"#add-#{model}-entry-link\").hide();#{additional_javascript}"), :id=> "add-#{model}-entry-link", :class=>"add-child-form-link admin-link")
   end
   def association_select_link(name, f, model)
     select_field = new_select_field(f, model.to_sym)
     link_to_function(name, raw("replace_content(this, \"#{model}\", \"#{escape_javascript(select_field)}\");$(\"#add-#{model}-select-link\").hide();$(\"#add-#{model}-entry-link\").show();"), :id=> "add-#{model}-select-link", :class=>"add-child-select-link admin-link", :style=>"display:none")
   end
  def new_vendor_link(name, f)
    fields = new_child_fields(f, :vendor)
    link_to_function(name, raw("replace_content(this, \"vendor\", \"#{escape_javascript(fields)}\");$(\"#add-vendor-select-link\").show();$(\"#add-vendor-entry-link\").hide();"), :id=> "add-vendor-entry-link", :class=>"add-child-form-link admin-link")
  end
  def vendor_select_link(name, f)
    select_field = new_select_field(f, :vendor)
    link_to_function(name, raw("replace_content(this, \"vendor\", \"#{escape_javascript(select_field)}\");$(\"#add-vendor-select-link\").hide();$(\"#add-vendor-entry-link\").show();"), :id=> "add-vendor-select-link", :class=>"add-child-select-link admin-link", :style=>"display:none")
  end
  def new_exhibition_venue_link(name, f)
    fields = new_child_fields(f, :exhibition_venue)
    link_to_function(name, raw("replace_content(this, \"exhibition-venue\", \"#{escape_javascript(fields)}\");$(\"#add-exhibition-venue-select-link\").show();$(\"#add-exhibition-venue-entry-link\").hide();"), :id=> "add-exhibition-venue-entry-link", :class=>"add-child-form-link admin-link")
  end
  def exhibition_venue_select_link(name, f)
    select_field = new_select_field(f, :exhibition_venue)
    link_to_function(name, raw("replace_content(this, \"exhibition-venue\", \"#{escape_javascript(select_field)}\");$(\"#add-exhibition-venue-select-link\").hide();$(\"#add-exhibition-venue-entry-link\").show();"), :id=> "add-exhibition-venue-select-link", :class=>"add-child-select-link admin-link", :style=>"display:none")
  end
  def add_child_link(name, f, method, additional_javascript = "")
    fields = new_child_fields(f, method)
    link_to_function(name, raw("insert_fields(this, \"#{method}\", \"#{escape_javascript(fields)}\");#{additional_javascript}"), :id=> "add-#{method.to_s.singularize}-entry-link", :class=>"add-child-form-link admin-link")
  end
  def new_child_fields(form_builder, method, options = {})
    options[:object] ||= form_builder.object.class.reflect_on_association(method).klass.new
    options[:partial] ||= method.to_s.singularize
    options[:form_builder_local] ||= :f
    form_builder.fields_for(method, options[:object], :child_index => "new_#{method}") do |f|
      render(:partial => options[:partial], :locals => { options[:form_builder_local] => f })
    end
  end
  def new_select_field(form_builder, method, options={})
    options[:object] ||= form_builder.object.class.reflect_on_association(method).klass.new
    options[:partial] ||= method.to_s.singularize + "_select"
    options[:form_builder_local] ||= :f
    form_builder.fields_for(method, options[:object], :child_index => "new_#{method}") do |f|
      render(:partial => options[:partial], :locals => { options[:form_builder_local] => f })
    end
  end

  def pluralize(string, count)
    count > 1 ? string.pluralize : string
  end

  def formatted_publisher_info(item)
   info = [item.publisher_name, item.publisher_city].reject(&:blank?).join("; ")
   [info, item.publisher_state.try(:upcase)].reject(&:blank?).join(", ")
  end
end
