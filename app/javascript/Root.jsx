// @flow

import 'babel-polyfill';
import 'bootstrap';
import * as React from 'react';
import { ApolloProvider } from 'react-apollo';
import { BrowserRouter as Router } from 'react-router-dom';
import { Route, Switch } from 'react-router';

import App from './App';
import Hello from 'components/Hello';
import ZooContainer from 'containers/ZooContainer';
import Login from 'components/Login';
import SignUp from 'components/SignUp';
import { NAME } from './env';
import apolloClient from './apollo/client';

type ComponentDidCatchInfo = {
  extra: mixed,
};

type Props = {};

class Root extends React.Component<Props> {
  constructor(props: Props) {
    super(props);
    document.title = NAME;
  }

  componentDidCatch(_error: Error, _info: ComponentDidCatchInfo) {
    // TODO(grrr): If you'd like, you can do some special error handling here,
    // e.g. show a bug report interstitial or an alert.
  }

  render(): React.Node {
    return (
      <ApolloProvider client={apolloClient}>
        <Router>
          <Switch>
            <Route path="/hello" component={Hello} />
            <Route
              path="/zoo/:id"
              render={(props: *): * => (<ZooContainer id={props.match.params.id} />)}
            />
            <Route path="/sign_in" component={Login} />
            <Route path="/sign_up" component={SignUp} />
            {/* For redirecting purposes as a catch-all */}
            <Route component={App} />
          </Switch>
        </Router>
      </ApolloProvider>
    );
  }
}
export default Root;
