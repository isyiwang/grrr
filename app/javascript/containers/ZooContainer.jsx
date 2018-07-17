// @flow

import React, { Component } from 'react';
import { graphql } from 'react-apollo';
import type { OperationComponent, QueryProps } from 'react-apollo';
import gql from 'graphql-tag';
// $FlowIgnore
import ZooQuery from 'graphql/zoo.graphql';

type TAnimal = {
  id: string,
  name: string,
  gender: string,
  species: string,
};

type TZoo = {
  name: string,
  animals: TAnimal[],
};

type TResponse = {
  zoo: TZoo,
};

type TProps = TResponse & QueryProps;

class Zoo extends Component<TProps> {
  render() {
    const { loading, zoo } = this.props;

    if (loading) {
      return <div>Loading...</div>;
    }

    return (
      <div className="container">
        <h4>{zoo.name}</h4>
        <ul className="list-group">
          {
            zoo.animals.map((animal) => (
              <li className="list-group-item" key={animal.id}>{animal.name}</li>
            ))
          }
        </ul>
      </div>
    );
  }
}

const queryWrapper: OperationComponent<TResponse, {/* InputProps */}, TProps> = graphql(ZooQuery, {
  props: ({ data }) => ({ ...data }),
});

export default queryWrapper(Zoo);
