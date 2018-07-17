// @flow

import { combineReducers } from 'redux';

import { allReducers } from './combinedReducers';
import type { TReduxAction, TReduxState } from '../types';

// The outer-most reducer is used to allow for resetting the whole redux state via the RESET_APP action.
// cf. Dan Abramov's answer in
// https://stackoverflow.com/questions/35622588/how-to-reset-the-state-of-a-redux-store/35641992#35641992
export default (state: TReduxState | void, action: TReduxAction) => {
  if ('RESET_APP' === action.type) {
    state = undefined;
  }

  return combineReducers(allReducers)(state, action);
};
