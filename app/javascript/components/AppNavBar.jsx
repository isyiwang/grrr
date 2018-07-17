// @flow

import glamorous from 'glamorous';
import React from 'react';
import { withRouter } from 'react-router';
import { compose } from 'recompose';

import Loading from 'components/Loading';
import withViewer from 'helpers/withViewer';

const Nav = glamorous.nav({
  alignItems: 'center',
  display: 'flex',
  flexWrap: 'wrap',
  justifyContent: 'space-between',
  minHeight: '3.6rem',
  paddingLeft: '1rem',
  paddingRight: '1rem',
  paddingTop: '0.5rem',
  paddingBottom: '0.5rem',
  position: 'relative',
});

type Props = {
  loadingViewer: boolean,
};

const AppNavBar = ({ loadingViewer }: Props) => {
  if (loadingViewer) {
    return <Loading />;
  }

  const leftComponent = <span>GRRR</span>; // TODO(grrr): replace with your app name
  const rightComponent = <span>TODO</span>;

  return (
    <Nav>
      { leftComponent }
      { rightComponent }
    </Nav>
  );
};

export default withRouter(
  compose(
    withViewer,
  )(AppNavBar)
);
