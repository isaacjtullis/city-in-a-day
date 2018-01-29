import 'babel-polyfill';
import React, {Component} from 'react';
import ReactDOM from 'react-dom';
import LocationList from './LocationList.js';

class App extends Component {
  constructor(props){
    super(props)
    this.state = {
      items: [name: 'Item 1', name: 'Item 2', name: 'Item 3']
    };
    this.onSortEnd = this.onSortEnd.bind(this);
  }
  
  onSortEnd({oldIndex, newIndex}) {
    this.setState({
      items: arrayMove(this.state.items, oldIndex, newIndex),
    });
  };

  render(){
    return (
      <div>
        <LocationList />
      </div>
    );
  }
}

export default App;
