// @flow

const datasetVar = (key: string, defaultVal?: *) => (
  (document && document.body && document.body.dataset && document.body.dataset[key]) || defaultVal
);

const env = datasetVar('env', 'production');
export default env;

export const IS_PROD = 'production' === env;
export const NAME = 'grrr'; // TODO(grrr): change to your app name
export const IS_LOGGED_IN = 'true' === datasetVar('signedIn', 'false');
