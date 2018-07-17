// @flow

import type { Store } from 'redux';

import type { TReducers } from './reducers/combinedReducers';

// ----- REDUX TYPES -----

export type TReduxNameState = { name: string | null };
export type TReduxHistoryState = { location: ?string };

// cf. https://flow.org/en/docs/types/utilities/#objmapt-f-a-classtoc-idtoc-objmap-hreftoc-objmapa
// and https://blog.callstack.io/type-checking-react-and-redux-thunk-with-flow-part-2-206ce5f6e705
// eslint-disable-next-line flowtype/no-weak-types
type $ExtractFunctionReturn = <V>(v: (...args: any) => V) => V;
export type TReduxState = $ObjMap<TReducers, $ExtractFunctionReturn>;

export type TReduxAction =
  | { type: 'RESET_APP' }
  | { type: 'UPDATE_NAME', name: string }
  // eslint-disable-next-line semi-style
  ;

// Guided by Redux typing docs: https://flow.org/en/docs/react/redux/
export type TReduxDispatch =
  // eslint-disable-next-line flowtype/no-weak-types, no-use-before-define
  (action: TReduxAction | TReduxThunkAction | TReduxPromiseAction | Array<TReduxAction>) => any;
export type TReduxGetState = () => TReduxState;
// eslint-disable-next-line flowtype/no-weak-types
type TReduxThunkAction = (dispatch: TReduxDispatch, getState: TReduxGetState) => any;
type TReduxPromiseAction = Promise<TReduxAction>;
export type TReduxStore = Store<TReduxStore | void, TReduxAction, TReduxDispatch>;
