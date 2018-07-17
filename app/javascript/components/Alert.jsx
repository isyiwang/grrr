// @flow

import classNames from 'classnames';
import React from 'react';

type Props = {
  dismissable?: boolean,
  title: string,
  description?: string,
  retry?: () => void,
  onDismiss?: () => void,
  type?: string,
};

const alertStyle = {
  left: '50vw',
  marginLeft: '-25vw',
  position: 'fixed',
  top: '5px',
  width: '50vw',
  'zIndex': '99',
};

export default({
  description,
  dismissable = true,
  onDismiss,
  retry,
  title,
  type = 'warn',
}: Props) => {
  const alertClasses = [
    'alert',
    'alert-dismissable',
    'animated',
    'fadeIn',
    'fade',
    'show',
  ];

  switch(type) {
    case 'success':
      alertClasses.push('alert-success');
      break;
    case 'danger':
      alertClasses.push('alert-danger');
      break;
    case 'info':
      alertClasses.push('alert-info');
      break;
    case 'warn':
    default:
      alertClasses.push('alert-warning');
      break;
  }

  return (
    <div
      className={classNames(alertClasses)}
      role="alert"
      style={alertStyle}
    >
      <strong>{title}</strong>
      {
        dismissable && (
          <button
            aria-label="Close"
            className="close"
            data-dismiss="alert"
            type="button"
            onClick={() => onDismiss && onDismiss()}
          >
            <span aria-hidden="true">&times;</span>
          </button>
        )
      }
      <p>{ description }</p>
      <div className="mt-1 row">
        {
          retry && (<button className="btn btn-link" onClick={() => retry && retry()} type="button">Retry</button>)
        }
      </div>
    </div>
  );
}
