	$(document).ready(function() {
	  getRecentImages();
	  getRecentItems();
	});
function getRecentImages(){
  $.getJSON('http://reanimationlibrary.org/catalog/digital_assets/most_recent.json?callback=?', function(data) {
    var items = [];
    data.sort( randOrd );
    data = data.slice(0, 9);
    $.each(data, function(key, val) {
      items.push('<div id="image_' + key + '"><a href="http://reanimationlibrary.org/catalog/digital_assets/' + val.id + '"><img src="http://reanimationlibrary.org' + val.mini_url + '" alt = "' + key + '" /></a></div>');
    });

    $('<div/>', {
      'class': 'recent-images-content',
      html: items.join('')
    }).appendTo('#recent-images');
  });
}
function getRecentItems(){
  $.getJSON('http://reanimationlibrary.org/catalog/items/recent.json?callback=?', function(data) {
    var items = [];

    $.each(data, function(key, val) {
    
      items.push('<div id="item_' + key + '"><a href="http://reanimationlibrary.org/catalog/items/' + val.id + '">' + val.display_title + '</a></div>');
    });

    $('<div/>', {
      'class': 'recent-items-content',
      html: items.join('')
    }).appendTo('#recent-acquisitions');
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