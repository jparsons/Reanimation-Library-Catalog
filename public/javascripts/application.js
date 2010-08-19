function remove_fields(link) {
  $(link).prev("input[type=hidden]").val("1");
  $(link).closest(".subform").hide();
}
 
function insert_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  $(link).parent().before(content.replace(regexp, new_id));
}

function replace_content(link, association, content){
  $("#"+association).html(content);	
  //$(link).parent().hide();
}

function remove_field(element, item) {
  element.up(item).remove();
}



