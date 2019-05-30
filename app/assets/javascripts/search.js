$(document).ready(function(){
	// $(document).on('page:change', function () {
		$("div#sample").hide();

    //    | === HERE
    $("a.toggle-formed").click(function(event) {
    	event.preventDefault();
    	$("div#sample").fadeToggle();
    	$("#search").focus();
    });
});

