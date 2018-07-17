// @flow

import * as React from 'react';
import type { OperationComponent } from 'react-apollo';
import { graphql } from 'react-apollo';
import { branch, compose } from 'recompose';
// $FlowIgnore
import CurrentViewer from 'graphql/CurrentViewer';
import hoistStatics from 'hoist-non-react-statics';

import { IS_LOGGED_IN } from '../env';
import type { CurrentViewerQuery } from '../graphqlTypes';

export type TUser = {|
  id: string,
  userType: string,
  email: string,
  name: string,
  image: ?string,
|};

type Props = {
  viewerData: OperationComponent<CurrentViewerQuery>,
  wrappedRef: ?Function,
};

const withViewer = (Component: React.ComponentType<*>) => {
  const C = compose(
    branch(
      () => IS_LOGGED_IN,
      graphql(CurrentViewer, { name: 'viewerData' }),
    ),
  )((props: Props) => {
    const { wrappedRef, viewerData, ...remainingProps } = props;

    return (
      <Component
        { ...remainingProps }
        currentViewer={ viewerData && viewerData.viewer }
        loadingCurrentViewer={ viewerData && viewerData.loading }
        ref={ wrappedRef }
      />
    );
  });

  C.displayName = `withuser(${Component.displayName || Component.name})`;
  C.WrappedComponent = Component;

  return hoistStatics(C, Component);
};

export default withViewer;
