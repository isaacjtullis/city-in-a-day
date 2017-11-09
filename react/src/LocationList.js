import 'babel-polyfill';
import React from 'react';
import ReactDOM from 'react-dom';
import {SortableContainer, SortableElement, arrayMove} from 'react-sortable-hoc';
/*
const SortableItem = SortableElement(({value}) =>
  <li>{value}</li>
);

const SortableItem = SortableElement((props) => {
  console.log('hitting sortable item');
  console.log('--------------');
  console.log("checking props");
  console.log(props)
  console.log('--------------');
  return(
    <div className="row display-locations col-md-offset-1">
      <div className="complete-location col-md-4">
        <li>{props.name}</li>
        <li>{props.location}</li>
        <li>{props.description}</li>
        <li>{props.price}</li>
        <li>{props.order}</li>
      </div>
    )
  }
});

const SortableList = SortableContainer(locations => {
  console.log('hitting sortable list');
  console.log('--------------');
  console.log("checking locations");
  console.log(locations);
  console.log('--------------');
  return (
    <ul className="location-list-items">
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

// $(function() {
//   $("#location-form").submit(function(e){
//     e.preventDefault();
//     var locationCreator = LocationList();
//     locationCreator.create();
//   });
// });

class LocationList extends React.Component {
  constructor(props){
    super(props)
    this.state = {
      completeLocation: [],
      name: '',
      location: '',
      description: '',
      price: '',
      order: '',
      photos: ''
    }
    this.handleChange = this.handleChange.bind(this);
    this.onSortEnd = this.onSortEnd.bind(this);
    // this.printLocationForm = this.printLocationForm.bind(this);
    // this.stopLocationForm = this.stopLocationForm.bind(this);
    this.postForm = this.postForm.bind(this);
  }

  handleChange(e){
    this.setState({[e.target.name]: e.target.value});
  }

  componentDidMount() {
    const self = this;
    console.log('component did mount');
    console.log(this.state.completeLocation);
    const res = window.location.pathname.match(/^\/trails\/(\d+)/);

    document.querySelector("form#new_location").addEventListener("submit", function(e){
      e.preventDefault();    //stop form from submitting
      console.log("I am inside of my event listener for new location submission");
      self.postForm();
    });

    let request = $.ajax({
      method: "GET",
      data: { location: res[1] },
      url: `/api/v1/locations`
    });

    request.done((data) => {
      // let sortedData = data.map(info =>{
      //   return info.order;
      // });
      let sortedData = sortBy(data, (info) => {
        console.log('checking data and info');
        console.log('------');
        console.log(info);
        console.log('--------');
        return info.order;
      });
      if(sortedData.length !== 0) {
        sortedData.map((info)=>{
          this.setState({ completeLocation: [...this.state.completeLocation, info] })
        })
      }
    })
  }

  handleEvent() {
    console.log('testing this');
  }

  enableForm() {
    var locationForm = $("form")[0].elements;
    setTimeout(function(){
      var btn = document.getElementById("location-creator");
      btn.removeAttribute('disabled');
    }, 1000);

    locationForm[2].value = '';
    locationForm[3].value = '';
    locationForm[4].value = '';
    locationForm[5].value = '';
    locationForm[6].value = '';
    locationForm[7].value = '';
  }

  postForm() {
      console.log('length of complete locations');
      console.log(this.state.completeLocation.length);
      const res = window.location.pathname.match(/^\/trails\/(\d+)/);
      var locationForm = $("form")[0].elements;
      var location = locationForm[2].value;
      var description = locationForm[3].value;
      var name = locationForm[4].value;
      var price = locationForm[5].value;
      var trailID = res[1];
      var photos = locationForm[7].value;
      var order = this.state.completeLocation.length;

      console.log('these are the most recent changes');
      const locationDetails = {
        location: location,
        description: description,
        name: name,
        price: price,
        trail_id: trailID,
        photos: photos,
        order: order
      }

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
        photos: ''
      })
      this.enableForm();
  }
  // makeLocation(e){
  //   console.log('making location');
  //   e.preventDefault();
  //   if(this.state.name !== '' && this.state.location !== '' && this.state.description !== '' && this.state.price !== '') {
  //     const res = window.location.pathname.match(/^\/trails\/(\d+)/);
  //     const name = this.state.name;
  //     const location = this.state.location;
  //     const description = this.state.description;
  //     const price = this.state.price;
  //     const trail_id = res[1];
  //     const order = this.state.completeLocation.length;
  //     const photos = this.state.photos;
  //     const locationDetails = {
        // location: location,
        // description: description,
        // name: name,
        // price: price,
        // trail_id: trail_id,
        // order: order,
        // photos: photos
  //     };
  //
    //   var request = $.ajax({
    //     method: "POST",
    //     url: '/api/v1/locations',
    //     data: { location: locationDetails }
    //   });
    //
    //   this.setState({
    //     completeLocation: [...this.state.completeLocation, locationDetails],
    //     name: '',
    //     location: '',
    //     description: '',
    //     price: '',
    //     order: '',
    //     photos: ''
    //   })
    // } else {
    //   return <div>There is an error with your form</div>
    // }
  // }

  onSortEnd({oldIndex, newIndex}) {
    console.log('hitting on sort end');
    console.log('checking old index and new index');
    console.log(oldIndex, newIndex);
    console.log('---------');
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

  render() {
    const locations = this.state.completeLocation;
    console.log(this.state.completeLocation)
    return (
      <div>
        <SortableList key={0} locations={this.state.completeLocation} onSortEnd={this.onSortEnd} />
      </div>
    );
  };
}

export default LocationList;
