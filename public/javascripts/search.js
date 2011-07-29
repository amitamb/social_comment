$(document).ready(function(){
	
	var config = {
		type		: 'web',
		append		: false,
		perPage		: 8,			// A maximum of 8 is allowed by Google
		page		: 0				// The start page
	}
  
  var last_selected_url = null;
  
  $("#search").click(function(){
    if ( config.term = $("#status").val() ){
      if (config.term == last_selected_url){
        $("#main-dropdown").toggleClass('show hide');
      }
      else
      {
        googleSearch();
      }
    }
		return false;
  });
  
  $(document).click(function(){
    if($('#main-dropdown').hasClass('show')) {
        $("#main-dropdown").toggleClass('hide show');
    }
  });
  
  $("#main-dropdown").click(function(){
    event.stopPropagation();
  });
	
	
	function googleSearch(settings){
		
		// If no parameters are supplied to the function,
		// it takes its defaults from the config object above:
		
		settings = $.extend({},config,settings);
		settings.term = settings.term;
		
		// URL of Google's AJAX search API
		var apiURL = 'http://ajax.googleapis.com/ajax/services/search/'+settings.type+'?v=1.0&callback=?';
		var resultsDiv = $('#resultsDiv');
		
		$.getJSON(apiURL,{q:settings.term,rsz:settings.perPage,start:settings.page*settings.perPage},function(r){
			
			var results = r.responseData.results;

      var dropdown = $("#dropdown");

      dropdown.html("");
      
      $("#main-dropdown").toggleClass('show hide');

      if (results.length){
        for (var i=0, len = results.length; i < len ; i++){
          var r = results[i];

          var new_item = $("<li><a href='"+ r.unescapedUrl +"'>" + r.visibleUrl + "</a></li>")
          new_item.children("a").click(function(){
            var url = $(this).attr("href");
            $("#main-dropdown").toggleClass('hide show');
            $("#status").val(url);
            last_selected_url = url;
            $("#status").change();
            return false;
          });
          new_item.appendTo(dropdown);
        }
      }

		});
	}

});
