// @flow

import { configureStore as configureStoreProd } from './configureStore.prod';
import { configureStore as configureStoreDev } from './configureStore.dev';
import env from '../env';

// Yes this is really how you do conditional exporting.
let chosenConfigureStore;

if ('production' === env) {
  chosenConfigureStore = configureStoreProd;
} else {
  chosenConfigureStore = configureStoreDev;
}

export const configureStore = chosenConfigureStore;
