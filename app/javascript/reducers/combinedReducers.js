// @flow

import name from './name';

// The overall combined reducer for the whole app.
// Note it includes both Apollo and non-apollo reducers.
export const allReducers = {
  name,
};

export type TReducers = typeof allReducers;
