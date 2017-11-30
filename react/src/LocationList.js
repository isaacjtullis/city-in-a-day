import 'babel-polyfill';
import React from 'react';
import ReactDOM from 'react-dom';
import { SortableContainer, SortableElement, arrayMove } from 'react-sortable-hoc';
import { sortBy } from 'lodash';

const SortableItem = SortableElement((props) => {
  return(
    <div className="row display-locations col-md-offset-1">
      <div className="complete-location col-md-4">
        <li>{props.name}</li>
        <li>{props.location}</li>
        <li>{props.description}</li>
        <li>{props.price}</li>
        <li>{props.order}</li>
      </div>
    </div>
  )
});

// $(function() {
//   $("#stop-location-form").submit(function(event){
//     event.preventDefault();
//     var locationForm = newLocationForm("#stop-location-form");
//     var locationCreator = newLocationCreator(locationForm.attributes().name, locationForm.attributes().location, locationForm.attributes().description, locationForm.attributes().price, locationForm.attributes().trail_id, "div#location-information");
//     locationCreator.create();
//   });
// })

const SortableList = SortableContainer(locations => {
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
    this.onSortEnd = this.onSortEnd.bind(this);
    this.checkForSubmission = this.checkForSubmission.bind(this);
    this.postForm = this.postForm.bind(this);
    this.makeLocation = this.makeLocation.bind(this);
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
      self.makeLocation();
    });
    // const self = this;
    // // const res = window.location.pathname.match(/^\/trails\/(\d+)/);
    //
    // document.querySelector("form#new_location").addEventListener("submit", function(e){
    //   e.preventDefault();    //stop form from submitting
    //   console.log("I am inside of my event listener for new location submission");
    //   self.makeLocation();
    // });
    // console.log('is this ever getting called?');
    // const res = window.location.pathname.match(/^\/trails\/(\d+)/);

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

    // const element = document.querySelector('form');
    // element.addEventListener('submit', e => {
    //   e.preventDefault();
    //   console.log('making the call to make a location');
    //   makeLocation();
    // });
    // form submit is undefined


    // $("#form-submit").submit(function(e){
    //   document.getElementById('form-submit').onSubmit()
    //   e.preventDefault();
    //   console.log('did I make it in here?');
    //   makeLocation();
    // })
    // $(function() {
    //   $("#stop-location-form").submit(function(event){
    //     event.preventDefault();
    //     var locationForm = newLocationForm("#stop-location-form");
    //     var locationCreator = newLocationCreator(locationForm.attributes().name, locationForm.attributes().location, locationForm.attributes().description, locationForm.attributes().price, locationForm.attributes().trail_id, "div#location-information");
    //     locationCreator.create();
    //   });
    // })
  }


  checkForSubmission(){
    console.log('inside of check for submission');
    // const element = document.querySelector('form');
    // $('#form-submit')[0].submit(function(e){
    //   e.preventDefault
    //   this.makeLocation();
    // });
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

  makeLocation(){

  const res = window.location.pathname.match(/^\/trails\/(\d+)/);
  var locationForm = $("form")[0].elements;
  var location = locationForm[2].value;
  var description = locationForm[3].value;
  var name = locationForm[4].value;
  var price = locationForm[5].value;
  var trailID = res[1];
  var photos = locationForm[7].value;
  console.log('am I adding a photo to this?');
  console.log(photos);
  console.log(locationForm);
  var order = this.state.completeLocation.length;
  if(name !== '' && description !== '' && price !== '' && location !== ''){

  //   const name = document.getElementById("location_name");
  //   const location = document.getElementById("location_location");
  //   const description = document.getElementById("location_description");
  //   const price = document.getElementById("location_price");
  //       // I am going to grab the values of the form (and I need to prevent default)
  //         const res = window.location.pathname.match(/^\/trails\/(\d+)/);
  //         // const name = document.getElementById("location_name");
  //         // const location = document.getElementById("location_location");
  //         // const description = document.getElementById("location_description");
  //         // const price = document.getElementById("location_price");
  //         const trail_id = res[1];
  //         const order = this.state.completeLocation.length;
          const locationDetails = {
            location: location,
            description: description,
            name: name,
            price: price,
            trail_id: trailID,
            photos: photos,
            order: order
          };
  //
  //         // document.getElementById("location_name") = '';
  //         // document.getElementById("location_location") = '';
  //         // document.getElementById("location_description") = '';
  //         // document.getElementById("location_price") = '';
  //
          var request = $.ajax({
            method: "POST",
            url: '/api/v1/locations',
            data: { location: locationDetails }
          });
  //
          this.setState({
            completeLocation: [...this.state.completeLocation, locationDetails],
            name: '',
            location: '',
            description: '',
            price: '',
            order: ''
          })
          this.enableForm();
        // });
      } else {
        this.enableForm();
        console.log('fail!');
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

  render() {
    return (
      <div>
        <div className="react-locations">
          <SortableList key={0} locations={this.state.completeLocation} onSortEnd={this.onSortEnd} />
        </div>
      </div>
    );
  };
}

export default LocationList;
