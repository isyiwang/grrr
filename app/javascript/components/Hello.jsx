import PropTypes from 'prop-types';
import React from 'react';

type State = {
  name: ?string,
};

class Hello extends React.Component<{}, State> {
  constructor(props: {}) {
    super(props);
    this.state = { name: null };
  }

  render() {
    const label = this.state.name ? `Hello ${this.state.name}!` : "Hello!";
    return (
      <div>
        <h3>{label}</h3>
        <hr />
        <form >
          <label htmlFor="name">
            Say hello to:
          </label>
          <input
            id="name"
            type="text"
            value={this.state.name || ''}
            onChange={(e) => this.setState({name: e.target.value})}
          />
        </form>
      </div>
    );
  }
}

export default Hello;
