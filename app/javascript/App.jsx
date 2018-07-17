// @flow

import glamorous from 'glamorous';
import React from 'react';
import { Route } from 'react-router-dom';
import { Switch, withRouter } from 'react-router';
import AppNavBar from 'components/AppNavBar';

type Props = ContextRouter & QueryProps;

const Wrapper = glamorous.div({
  height: '100%',
  display: 'flex',
  flexDirection: 'column',
});

const Container = glamorous.div({
  flexDirection: 'row',
  flexGrow: '1',
  width: '100%',
  display: 'flex',
  overflow: 'hidden',
});

const Main = glamorous.main({
  overflow: 'auto',
});

const App = () => {
  return (
    <Wrapper>
      <AppNavBar />
      <Main>
        <Switch>
          {/* Fallback to home page. */}
          <Redirect to={{ pathname: '/' }} />
        </Switch>
      </Main>
    </Wrapper>
  );
};

export default withRouter(App);
