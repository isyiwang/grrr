// @flow

import { InMemoryCache } from 'apollo-cache-inmemory';
import { ApolloClient } from 'apollo-client';
import { createUploadLink } from 'apollo-upload-client';
import $ from 'jquery';

const uploadLink = createUploadLink({
  fetchOptions: {
    credentials: 'same-origin',
    headers: {
      'X-CSRF-Token': $('meta[name=csrf-token]').attr('content'),
    },
  },
  fetch: window.fetch,
  uri: '/graphql',
});

const apolloClient = new ApolloClient({
  cache: new InMemoryCache(),
  link: uploadLink,
});

export default apolloClient;
