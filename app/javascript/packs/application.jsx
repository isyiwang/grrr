// @flow

/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

import { createBrowserHistory } from 'history';
import { AppContainer } from 'react-hot-loader';
import { render } from 'react-dom';
import _ from 'lodash';
import React from 'react';

// $FlowIgnore
import '../src/application.css';
import { configureStore } from '../store/configureStore';
import { loadState, saveState } from '../localStorage';
import Root from '../Root';

const history = createBrowserHistory();

const store = configureStore(loadState());
store.subscribe(_.throttle(() => (saveState(store.getState())), 1000));

document.addEventListener('DOMContentLoaded', () => (
  render(
    <AppContainer>
      <Root history={history} store={store} />
    </AppContainer>,
    document.body && document.getElementById('root'),
  )
));

// Hot-loading
if (module.hot) {
  // $FlowIgnore
  module.hot.accept('../Root', () => {
    // $FlowIgnore
    const NextRoot = require('../Root'); // eslint-disable-line global-require
    render(
      <AppContainer>
        <NextRoot history={history} store={store} />
      </AppContainer>,
      document.body && document.getElementById('root'),
    );
  });
}
