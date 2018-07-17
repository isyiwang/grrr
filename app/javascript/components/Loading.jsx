// @flow

import React from 'react';

const divStyle = {
  alignItems: 'center',
  display: 'flex',
  height: '100%',
  justifyContent: 'center',
  width: '100%',
};

export default() => (
  <div className="animated zoomIn" style={divStyle}>
    <i className="fa fa-circle-o-notch fa-spin" style={{ fontSize: '4rem' }}></i>
  </div>
);
