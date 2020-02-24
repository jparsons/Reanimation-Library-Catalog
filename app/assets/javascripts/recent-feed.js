	$(document).ready(function() {
	  getRecentImages();
	  getRecentItems();
    getDonors();
	});
function getRecentImages(){
  $.getJSON('/catalog/digital_assets/most_recent.json', function(data) {
    var items = [];
    data.sort( randOrd );
    data = data.slice(0, 9);
    $.each(data, function(key, val) {
      items.push('<div class="image" id="image_' + key + '"><a href="http://reanimationlibrary.org/catalog/digital_assets/' + val.id + '"><img src="http://reanimationlibrary.org' + val.mini_url + '" alt = "' + key + '" /></a></div>');
    });

    $('<div/>', {
      'class': 'recent-images-content',
      html: items.join('')
    }).appendTo('#recent-images');
  });
}
function getRecentItems(){
  $.getJSON('/catalog/items/recent.json', function(data) {
    var items = [];

    $.each(data, function(key, val) {

      items.push('<div id="item_' + key + '"><a href="http://reanimationlibrary.org/catalog/items/' + val.id + '">' + val.display_title_with_colon + '</a></div>');
    });

    $('<div/>', {
      'class': 'recent-items-content',
      html: items.join('')
    }).appendTo('#recent-acquisitions');
  });
}
function getDonors() {
  $.getJSON('http://reanimationlibrary.org/catalog/donors.json', function(data){
    var donors = [];
    $.each(data, function(key, val){
      donors.push('<div>' + val.display_name + '</div>');
    });

    $('<div/>', {
      'class': 'donors-content',
      html: donors.join('')
    }).appendTo('#donors');
  });

}
function randOrd(){
  return (Math.round(Math.random())-0.5);
}

function getCreator(data) {
	if (data.length > 0) {
	  return  ', ' + data;
    } else {
	  return ''
	}
}
