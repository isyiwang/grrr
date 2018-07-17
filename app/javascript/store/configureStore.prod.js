// @flow

import { applyMiddleware, compose, createStore } from 'redux';
import type { Store } from 'redux';
import thunk from 'redux-thunk';

import rootReducer from '../reducers';
import type { TReduxAction, TReduxDispatch, TReduxState } from '../types';

export function configureStore(
  initialState: TReduxState | void,
): Store<TReduxState | void, TReduxAction, TReduxDispatch> {
  return createStore(
    rootReducer,
    initialState,
    compose(applyMiddleware(thunk)),
  );
}
