/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

import { AppContainer } from 'react-hot-loader';
import { createBrowserHistory } from 'history';
import _ from 'lodash';
import React from 'react';
import ReactDOM from 'react-dom';

// $FlowIgnore
import '../src/application.css';
import Root from '../Root';

const history = createBrowserHistory();

const render = Component => {
  ReactDOM.render(
    <AppContainer>
      <Component />
    </AppContainer>,
    document.getElementById('root')
  );
}

document.addEventListener('DOMContentLoaded', () => (
  render(Root)
));

if (module.hot) {
  module.hot.accept('../Root', () => {
    const NextRootContainer = require('../Root').default;
    render(NextRootContainer);
  });
}
