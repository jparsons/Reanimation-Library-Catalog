$(function() {
	$(".select2").select2({
	  tags: true,
	  createTag: function (params) {
	    return {
	      id: params.term,
	      text: params.term,
	      newOption: true
	    }
	  }
	});
	$('#item_date_acquired').datepicker();
	$(document).on('nested:fieldAdded', function(event){
		$(".select2").select2({
			tags: true,
			createTag: function (params) {
				return {
					id: params.term,
					text: params.term,
					newOption: true
				}
			}
		});
	 })
});
