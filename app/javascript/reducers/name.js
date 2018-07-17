// @flow

import type { TReduxNameState, TReduxAction, TReduxState } from '../types';

const initialState: TReduxNameState = { name: null };

const reducer = (state: TReduxNameState = initialState, action: TReduxAction) => {
  switch (action.type) {
    case 'ACTION_NAME_SET': return { ...state, name: action.name };
    default: return state;
  }
};
export default reducer;

export const actions = {
  updateName: (name: string) => ({ type: 'ACTION_NAME_SET', name }),
};

export const getName = (state: TReduxState) => (state.name.name);
