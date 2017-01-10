// Add your new comment form code here
var newLocationForm = function(formId) {
  return {
    element: $(formId),
    name: function() {
      return this.element.find('#location_name').val();
    },
    location: function() {
      return this.element.find('#location_location').val();
    },
    description: function() {
      return this.element.find('#location_description').val();
    },
    price: function() {
      return this.element.find('#location_price').val();
    },
    trailId: function() {
      return this.element.find('#location_trail_id').val();
    },
    attributes: function() {
      var result = {
        name: this.name(),
        location: this.location(),
        description: this.description(),
        price: this.price(),
        trail_id: this.trailId()
      }
      return result;
    }
  }
}
