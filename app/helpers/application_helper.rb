# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def link_to_if_user_is_admin(condition, name, options = {}, html_options = {}, &block)

    if @current_user && @current_user.is_administrator? 
      link_to(condition, name, options, html_options, &block)
    else
      ''
    end
    
  end
  
  def add_subform_link(form_builder, classname)
    link_to_function "add #{classname} details", :id => "add-#{classname}-entry-link" do |page|
      form_builder.fields_for classname.pluralize.to_sym, classname.classify.constantize.new, "#{classname}index".to_sym => 'NEW_RECORD' do |f|
        html = render(:partial => classname, :locals => { :form => f})
        page << "$('#{classname.pluralize}').insert({bottom: '#{escape_javascript(html)}'.replace(/NEW_RECORD/g, new Date().getTime()) });"
      end
    end
  end

  # copied from http://github.com/ryanb/complex-form-examples
  def remove_child_link(name, f)
    f.hidden_field(:_delete, :value=>"0") + link_to_function(name, "remove_fields(this)")
  end
  
   # need to have a way to replace the dropdown with the new child form and vice versa ...
  
  def new_vendor_link(name, f)
    fields = new_child_fields(f, "vendor")
    link_to_function(name, h("replace_with_fields(this, \"#{method}\", \"#{escape_javascript(fields)}\")"), :id=> "add-#{method.to_s.singularize}-entry-link", :class=>"add-child-form-link")
  end
 
  def add_child_link(name, f, method)
    fields = new_child_fields(f, method)
    link_to_function(name, h("insert_fields(this, \"#{method}\", \"#{escape_javascript(fields)}\")"), :id=> "add-#{method.to_s.singularize}-entry-link", :class=>"add-child-form-link")
  end
  
  def new_child_fields(form_builder, method, options = {})
    options[:object] ||= form_builder.object.class.reflect_on_association(method).klass.new
    options[:partial] ||= method.to_s.singularize
    options[:form_builder_local] ||= :f
    form_builder.fields_for(method, options[:object], :child_index => "new_#{method}") do |f|
      render(:partial => options[:partial], :locals => { options[:form_builder_local] => f })
    end
  end
  
end
