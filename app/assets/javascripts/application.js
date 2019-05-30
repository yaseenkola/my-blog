// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require jquery3
//= require bootstrap-sprockets
//= require turbolinks
//= require search
//= require custom
//= require_tree .

/* global $ */

$(document).on('ready turbolinks:load', function() {

  $("a.test").on( "click", function( event ) { 
  var id = $(this).attr("id"); 
  var current_link = $(this); 
    $.ajax({ 
      url: "/blogs/" + id + "/toggle_status", 
      type: "GET", 
      dataType: "json", 
      success: function(r){ 
      // console.log(r["blog_status"]); 
      current_link.text(r["blog_status"]); // this will display the status of the blog 
      alert("Blog status has been updated"); 
      }  
    }); 
  }); 
});

 $(document).on('turbolinks:load', function() {
   $('#fade-out-target').fadeOut(4000);
 });
 