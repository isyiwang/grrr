/* @flow */
/* eslint-disable */
//  This file was automatically generated and should not be edited.

export type ZooQueryQueryVariables = {|
  id: string,
|};

export type ZooQueryQuery = {|
  // Get a Zoo by ID
  zoo: ? {|
    name: string,
    animals: ? Array<? {|
      id: string,
      name: string,
      gender: string,
      species: string,
    |} >,
  |},
|};

export type ZooInfoFragment = {|
  name: string,
  animals: ? Array<? {|
    id: string,
    name: string,
    gender: string,
    species: string,
  |} >,
|};