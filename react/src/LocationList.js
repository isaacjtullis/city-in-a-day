import 'babel-polyfill';
import React from 'react';
import ReactDOM from 'react-dom';
import {SortableContainer, SortableElement, arrayMove} from 'react-sortable-hoc';
import { sortBy } from 'lodash';

const SortableItem = SortableElement((props) => {
  return(
    <div className="locations-container col-md-12">
      <div className="complete-location col-md-offset-6 col-md-4">
        <li>{props.name}</li>
        <li>{props.location}</li>
        <li>{props.description}</li>
        <li>{props.price}</li>
        <li>{props.order}</li>
      </div>
    </div>
  )
});

$(function() {
  $("#stop-location-form").submit(function(event){
    event.preventDefault();
    var locationForm = newLocationForm("#stop-location-form");
    var locationCreator = newLocationCreator(locationForm.attributes().name, locationForm.attributes().location, locationForm.attributes().description, locationForm.attributes().price, locationForm.attributes().trail_id, "div#location-information");
    locationCreator.create();
  });
})

const SortableList = SortableContainer(locations => {
  return (
    <ul>
      {locations.locations.map((value, index) => (
        <SortableItem
          key={`location-${index}`}
          index={index}
          name={value.name}
          location={value.location}
          description={value.description}
          price={value.price}
          order={value.order}
        />
        ))
      }
    </ul>
  );
});

class LocationList extends React.Component {
  constructor(props){
    super(props)
    this.state = {
      completeLocation: [],
      name: '',
      location: '',
      description: '',
      price: '',
      order: ''
    }
    this.handleChange = this.handleChange.bind(this);
    this.makeLocation = this.makeLocation.bind(this);
    this.onSortEnd = this.onSortEnd.bind(this);
  }

  handleChange(e){
    this.setState({[e.target.name]: e.target.value});
  }

  componentDidMount() {
    const res = window.location.pathname.match(/^\/trails\/(\d+)/);

    let request = $.ajax({
      method: "GET",
      data: { location: res[1] },
      url: `/api/v1/locations`
    });

    request.done((data) => {
      let sortedData = sortBy(data, (info) => {
        return info.order;
      });
      if(sortedData.length !== 0) {
        sortedData.map((info)=>{
          this.setState({ completeLocation: [...this.state.completeLocation, info] })
        })
      }
    })
  }
  makeLocation(e){
    e.preventDefault();
    if(this.state.name !== '' && this.state.location !== '' && this.state.description !== '' && this.state.price !== '') {
      const res = window.location.pathname.match(/^\/trails\/(\d+)/);
      const name = this.state.name;
      const location = this.state.location;
      const description = this.state.description;
      const price = this.state.price;
      const trail_id = res[1];
      const order = this.state.completeLocation.length;
      const locationDetails = {
        location: location,
        description: description,
        name: name,
        price: price,
        trail_id: trail_id,
        order: order
      };

      //let data = { location: locationDetails };
      //let jsonStringData = JSON.stringify(data);

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
        order: ''
      })
    } else {
      return <div>There is an error with your form</div>
      //Error message Ajax call inside of a promise and handle the Error
      //In the catch
    }
  }

  onSortEnd({oldIndex, newIndex}) {
    const res = window.location.pathname.match(/^\/trails\/(\d+)/);
    const updateOrder = {
      oIndex: oldIndex,
      nIndex: newIndex,
      trail_id: res[1]
    }
    const num = oldIndex;

    var requestData = {
      method: "PATCH",
      url: `/api/v1/locations/${num}`,
      data: { location: updateOrder }
    }
    let request = $.ajax(requestData)
    this.setState({
      completeLocation: arrayMove(this.state.completeLocation, oldIndex, newIndex),
    });
  };

  printLocationForm() {
    return (
      <div id="location-form">
        <div className="new-location">
          <div className="col-md-4">
            <input
              type="text"
              name="name"
              value={this.state.name}
              placeholder="Name of Location"
              onChange={this.handleChange}
            />
            <input
              id="location_location"
              type="text"
              name="location"
              value={this.state.location}
              placeholder="Where was it?"
              onChange={this.handleChange}
            />
            <input
              type="text"
              name="description"
              value={this.state.description}
              placeholder="Tell us a little bit about it"
              onChange={this.handleChange}
            />
            <input
              type="text"
              name="price"
              value={this.state.price}
              placeholder="What was the price?"
              onChange={this.handleChange}
            />
            <button type="submit" className="btn btn-default" onClick={this.makeLocation}>Submit</button>
          </div>
        </div>
      </div>
    );
  }

  render() {
    return (
      <div>
        <div className="row react-locations">
          {this.printLocationForm()}
          <SortableList key={0} locations={this.state.completeLocation} onSortEnd={this.onSortEnd} />
        </div>
      </div>
    );
  };
}

export default LocationList;
