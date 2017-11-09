// var newLocationCreator = function(location, description, name, price, trailID, photos) {
//   debugger;
//   return {
//     name: name,
//     location: location,
//     description: description,
//     price: price,
//     trailID: trailID,
//     photos: photos,
//     create: function() {
//       var locationCreatorObject = this;
//       var request = $.ajax({
//         method: "POST",
//         url: '/api/v1/locations',
//         data: { location: { photos: photos, name: name, location: location, description: description, price: price, trail_id: trailID } }
//       });
//
//       request.done(function() {
//         var e = $('input')[8]
//         console.log('test when the request is finished');
//         // locationCreatorObject.setFlash("notice", "Your location is saved!");
//         locationCreatorObject.append();
//         locationCreatorObject.clearForm();
//         e.removeAttribute ('disabled');
//       });
//
//       request.error(function() {
//         var e = $('input')[8]
//         console.log('this is an error');
//         // locationCreatorObject.setFlash("error", "There was a problem with your comment.");
//         locationCreatorObject.clearForm();
//         e.removeAttribute ('disabled');
//       });
//     },
//     // setFlash: function(type, message) {
//     //   $("div.flash").remove();
//     //   var flash = $("<div>", { "class": "flash flash-" + type }).text(message);
//     //   $("#location-information").prepend(flash);
//     //   console.log(message);
//     // },
//     clearForm: function(){
//       $('#location_name').val("");
//       $('#location_location').val("");
//       $('#location_description').val("");
//       $('#location_price').val("");
//       $("input[value='Making new location']:first-child").removeAttr('disabled').attr('value', 'Add New Location');
//     },
//     append: function() {
//       console.log('It arrived in append');
//       console.log(this.name);
//       $('.location').append('<ul>' + this.name + '<br />' + this.location + '<br />' + this.description + '<br />' + this.price + '</ul>');
//     }
//   }
// };
