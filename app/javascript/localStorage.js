// @flow

import { IS_PROD } from './env';
import type { TReduxState } from './types';

const STATE_KEY = IS_PROD ?
  '__GRRRR_STATE_PROD_0.2.0-alpha' : '__GRRRR_STATE_DEV_KEY_0.2.0-alpha';

/* global localStorage */
// ^ cf. https://eslint.org/docs/rules/no-undef
export const loadState = (): TReduxState | void => {
  try {
    const serializedState: ?string = localStorage.getItem(STATE_KEY);
    return (serializedState) ? JSON.parse(serializedState) : undefined;
  } catch (err) {
    // eslint-disable-next-line no-console
    console.error('Unable to deserialize state:', err);
    return undefined;
  }
};

export const saveState = (state: TReduxState | void): void => {
  if (!state) {
    return;
  }

  try {
    const serializedState: string = JSON.stringify(state);
    localStorage.setItem(STATE_KEY, serializedState);
  } catch (err) {
    // eslint-disable-next-line no-console
    console.error(err);
  }
};
