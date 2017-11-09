import 'babel-polyfill';
import React, {Component} from 'react';
import ReactDOM from 'react-dom';
import LocationList from './LocationList.js';
/*
import {SortableContainer, SortableElement, arrayMove} from 'react-sortable-hoc';

const SortableItem = SortableElement(({value}) =>
  <li>{value}</li>
);

const SortableList = SortableContainer(({items}) => {
  return (
    <ul>
      {items.map((value, index) => (
        <SortableItem key={`item-${index}`} index={index} value={value} />
      ))}
    </ul>
  );
});
*/
class App extends Component {
  constructor(props){
    super(props)
    this.state = {
      items: [name: 'Item 1', name: 'Item 2', name: 'Item 3']
    };
    this.onSortEnd = this.onSortEnd.bind(this);
  }
<<<<<<< Updated upstream
=======

>>>>>>> Stashed changes
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

//return <SortableList items={this.state.items} onSortEnd={this.onSortEnd} />;
export default App;
