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
$(function () {
  if ($('.process-log').length > 0) {
    setTimeout(update_log_entries, 5000);
  }
});

function update_log_entries() {
  process_log_id = $(".process-log").attr("id");
  after_id = $(".entry:last").attr("id");
  if (after_id == undefined){
	after_id = "";
  } else {
	after_id = after_id.replace(/entry-/, "");
  }
  process_log_id = process_log_id.replace(/process-log-/, "");
  $.getScript('/catalog/log_entries.js?process_log_id=' + process_log_id + '&after_id=' + after_id);
  setTimeout(update_log_entries, 5000);
}

$(document).ready(function()
{
  $(".submit_button").click(function(){
	  $("#search_form").submit();
	  return false;
  });

  $("#q").focus(function(){
	if ($(this).val() == "search the catalog") {
		$(this).val('');
	}
  });
  $('a#show-advanced-search').click(function(){
	$('#basic-search-options').hide();
	$('#advanced-search-options').show();
	$.cookie("search-preference", "advanced");
	return false;
	});
  $('a#show-basic-search').click(function(){
	$('#advanced-search-options').hide();
	$('#basic-search-options').show();
	$.cookie("search-preference", "basic");
	return false;
	});
	
	$("#view-log").click(function() {
	  $(".process-log").toggle();
	});


});


