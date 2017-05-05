import 'babel-polyfill';
import React from 'react';
import ReactDOM from 'react-dom';
import {SortableContainer, SortableElement, arrayMove} from 'react-sortable-hoc';
/*
const SortableItem = SortableElement(({value}) =>
  <li>{value}</li>
);

const SortableList = SortableContainer(({locations}) => {
  if(locations.length > 0) {
    return (
      <ul>
        {locations.map((value, index) => (
          <SortableItem key={`location-${index}`} index={index} value={value} />
        ))}
      </ul>
    );
  } else {
    return (
      <div>
        Hi
      </div>
    )
  }
});
*/
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
class LocationList extends React.Component {
  constructor(props){
    super(props)
    this.state = {
      completeLocation: [],
      name: '',
      location: '',
      description: '',
      price: ''
    }
    this.handleChange = this.handleChange.bind(this);
    this.makeLocation = this.makeLocation.bind(this);
    this.onSortEnd = this.onSortEnd.bind(this);
  }

  handleChange(e){
    this.setState({[e.target.name]: e.target.value});
  }

  makeLocation(e){
    e.preventDefault();
    if(this.state.name !== '' && this.state.location !== '' && this.state.description !== '' && this.state.price !== '') {
      const res = window.location.pathname.match(/^\/trails\/(\d+)/);
      const name = this.state.name
      const location = this.state.location
      const description = this.state.description
      const price = this.state.price
      const trail_id = res[1];
      const locationDetails = {
        location: location,
        description: description,
        name: name,
        price: price,
        trail_id: trail_id
      }
      debugger;

      var request = $.ajax({
        method: "POST",
        url: '/api/v1/locations',
        data: { location: locationDetails }
      });
      //var request = new Request(url
      //{ Data: Data, body: body})
      this.setState({
        completeLocation: [...this.state.completeLocation, locationDetails],
        name: '',
        location: '',
        description: '',
        price: '',
      })
    } else {
      return <div>There is an error with your form</div>
      //Error message Ajax call inside of a promise and handle the Error
      //In the catch
    }
  }

  onSortEnd({oldIndex, newIndex}) {
    this.setState({
      completeLocation: arrayMove(this.state.completeLocation, oldIndex, newIndex),
    });
  };

  printLocationForm() {
    return (
      <div className="col-md-4">
        <label>Name of Location</label>
        <input
          type="text"
          name="name"
          value={this.state.name}
          placeholder="Name of Location"
          onChange={this.handleChange}
        />

        <label>Where was it?</label>
        <input
          type="text"
          name="location"
          value={this.state.location}
          placeholder="Where was it?"
          onChange={this.handleChange}
        />

        <label>Lil bit of info</label>
        <input
          type="text"
          name="description"
          value={this.state.description}
          placeholder="Tell us a little bit about it"
          onChange={this.handleChange}
        />

        <label>What was the PRICE?</label>
        <input
          type="text"
          name="price"
          value={this.state.price}
          placeholder="What was the price?"
          onChange={this.handleChange}
        />
        <button type="submit" className="btn btn-default" onClick={this.makeLocation}>Submit</button>
      </div>
    );
  }

  render() {
    const locations = this.state.completeLocation;
    console.log(this.state.completeLocation)
    return (
      <div>
        <div className="row react-locations">
          {this.printLocationForm()}
          {
            locations.map(location =>{
              return(
                <div className="row col-md-4 col-md-offset-2">
                  <h1>{location.name}</h1>
                  <h1>{location.location}</h1>
                  <h1>{location.description}</h1>
                  <h1>{location.price}</h1>
                </div>
              );
            })
          }
        </div>
        <div className="row col-md-4">
        </div>
      </div>
    );
  };
}

export default LocationList;
