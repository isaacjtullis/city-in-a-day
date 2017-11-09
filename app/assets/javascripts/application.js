// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require_tree .
<<<<<<< Updated upstream
/*
$(function() {
  $("#stop-location-form").submit(function(event){
    event.preventDefault();
    var locationForm = newLocationForm("#stop-location-form");
    var locationCreator = newLocationCreator(locationForm.attributes().name, locationForm.attributes().location, locationForm.attributes().description, locationForm.attributes().price, locationForm.attributes().trail_id, "div#location-information");
    locationCreator.create();
  });
});
*/
=======

// $(function() {
//   $("#location-form").submit(function(e){
//     e.preventDefault();
//     var locationForm = $("form")[0].elements;
//     var location = locationForm[2].value;
//     var description = locationForm[3].value;
//     var name = locationForm[4].value;
//     var price = locationForm[5].value;
//     var trailID = locationForm[6].value;
//     var photos = locationForm[7].value;
//     var locationCreator = newLocationCreator(location, description, name, price, trailID, photos);
//     locationCreator.create();
//   });
// });

// $(function() {
//   $("form#new_location").submit(function(e){
//     debugger;
//     e.preventDefault();
//     // var locationCreator = newLocationCreator(ributes().name, locationForm.attributes().location, locationForm.attributes().description, locationForm.attributes().price, locationForm.attributes().trail_id, locationForm.attributes().photos);
//     // locationCreator.create();
//   });
// });
// This works: trying to figure out why this works and not other things
// React is commented out -- I uncommented react and it broke
// JavaScript is commented out
// changed the id name for my form -- this was not the fix. I switched it back to the old id and it worked
//
>>>>>>> Stashed changes
