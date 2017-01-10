var newLocationCreator = function(nameAttributes, locationAttributes, descriptionAttributes, priceAttributes, trailidAttributes, divId) {
  return {
    name: nameAttributes,
    location: locationAttributes,
    description: descriptionAttributes,
    price: priceAttributes,
    trail_id: trailidAttributes,
    div: $(divId),
    create: function() {
      var locationCreatorObject = this;
      var request = $.ajax({
      method: "POST",
      url: '/api/v1/locations',
      data: { location: { name: locationCreatorObject.name, location: locationCreatorObject.location, description: locationCreatorObject.description, price: locationCreatorObject.price, trail_id: locationCreatorObject.trail_id } }
    });

      request.done(function() {
        locationCreatorObject.setFlash("notice", "Your location is saved!");
        locationCreatorObject.append();
        locationCreatorObject.clearForm();
      });

      request.error(function() {
        locationCreatorObject.setFlash("error", "There was a problem with your comment.");
        locationCreatorObject.clearForm();
      });
    },
    setFlash: function(type, message) {
      $("div.flash").remove();
      var flash = $("<div>", { "class": "flash flash-" + type }).text(message);
      $("#location-information").prepend(flash);
      console.log(message);
    },
    clearForm: function(){
      $('#location_name').val("");
      $('#location_location').val("");
      $('#location_description').val("");
      $('#location_price').val("");
      $("input[value='Making new location']:first-child").removeAttr('disabled').attr('value', 'Add New Location');
    },
    append: function() {
      $('.locations').append('<ul>' + this.name + '</ul>');
      $('.locations').append('<ul>' + this.location + '</ul>');
      $('.locations').append('<ul>' + this.description + '</ul>');
      $('.locations').append('<ul>' + this.price + '</ul>');
      $('.locations').append('<ul>' + '<hr>' + '</ul>')
    }
  }
};
