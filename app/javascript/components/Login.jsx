// @flow

import Alert from 'components/Alert';
import React from 'react';
import { compose, graphql } from 'react-apollo';

import { NAME } from '../env';
import './Login.css';

type Props = {
  event: ?string,
};

export default ({ event }: Props) => {
  const eventAlert = (
    event && 'confirmed' === event && (
      <Alert
        description="We've confirmed your email address. Please sign in now."
        title="Email confirmed!"
        type="success"
      />
    )
  );

  return (
    <div className="container">
      { eventAlert }
      <div className="mx-auto px-1 row vertically-centered">
        <div className="align-items-center d-flex flex-column justify-content-center mx-auto w-50">
          <h1 className="mb-5">GRRR</h1>{/* TODO(grrr) replace with app name */}
          <a
            className="btn btn-block btn-social btn-facebook w-50"
            href="/auth/facebook"
            style={{textAlign: 'center'}}
          >
            <span className="fa fa-facebook"></span> Sign in with Facebook
          </a>
          <a
            className="btn btn-block btn-social btn-google w-50"
            href="/auth/google_oauth2"
            style={{textAlign: 'center'}}
          >
            <span className="fa fa-google"></span> Sign in with Google
          </a>
          <small className="mt-5">
            By logging in, you agree to the <a href="/terms">Terms of Service</a> and <a href="privacy">Priacy Policy</a>.
          </small>
          <small className="mt-2">
            Don't have an account? <a href="/sign_up">Sign up</a>.
          </small>
        </div>
      </div>
    </div>
  );
};
