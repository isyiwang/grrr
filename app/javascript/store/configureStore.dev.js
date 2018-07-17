// @flow

import { applyMiddleware, createStore } from 'redux';
// eslint-disable-next-line import/no-extraneous-dependencies
import { composeWithDevTools } from 'redux-devtools-extension';
// eslint-disable-next-line import/no-extraneous-dependencies
import { createLogger } from 'redux-logger';
import thunk from 'redux-thunk';
import type { Store } from 'redux';

import type { TReduxAction, TReduxDispatch, TReduxState } from '../types';
import rootReducer from '../reducers';

export function configureStore(
  initialState: TReduxState | void,
): Store<TReduxState | void, TReduxAction, TReduxDispatch> {
  // Redux configuration
  const middleware = [];

  // Thunk middleware
  middleware.push(thunk);

  // Logging middleware
  middleware.push(createLogger({ collapsed: true, level: 'info' }));

  // Create Store.
  const store = createStore(
    rootReducer,
    initialState,
    composeWithDevTools(applyMiddleware(...middleware)),
  );

  if (module.hot) {
    // $FlowIgnore
    module.hot.accept('../reducers', () => {
      // $FlowIgnore
      store.replaceReducer(require('../reducers')); // eslint-disable-line global-require
    });
  }

  return store;
}
