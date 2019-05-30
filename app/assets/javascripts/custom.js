$(document).ready(function(){
	// $(document).on('page:change', function () {
		$("div#test").hide();

    //    | === HERE
    $("a.toggle-form").click(function(event) {
    	event.preventDefault();
    	$("div#test").fadeToggle();
    });
});
